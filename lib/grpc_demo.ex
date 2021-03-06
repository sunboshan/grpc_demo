defmodule GRPCDemo do
  def connect do
    {:ok, chan} = GRPC.Stub.connect("127.0.0.1:9527")
    chan
  end

  @doc """
  One request, one response.

      server         client
      ---------------------
       <- |req|
                  |res| ->
      ---------------------
  """
  def test1(chan) do
    {:ok, %ResHello{a: a}} = Hello.Stub.say_hello1(chan, ReqHello.new(a: 1))
    a
  end

  @doc """
  Stream requests, one response.

      server                client
      ----------------------------
       <- |req| <- |req| <- |req|
                |res| ->
      ----------------------------
  """
  def test2(chan) do
    stream = Hello.Stub.say_hello2(chan)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 1), end_stream: false)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 2), end_stream: false)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 3), end_stream: true)
    {:ok, %ResHello{a: a}} = GRPC.Stub.recv(stream)
    a
  end

  @doc """
  One request, stream responses.

      server                client
      ----------------------------
                <- |req|
       |res| -> |res| -> |res| ->
      ----------------------------
  """
  def test3(chan) do
    {:ok, stream} = Hello.Stub.say_hello3(chan, ReqHello.new(a: 1))
    Enum.each(stream, &IO.inspect(&1, label: "client got res"))
  end

  @doc """
  Stream requests, stream responses.

      server                client
      ----------------------------
       <- |req| <- |req| <- |req|
       |res| -> |res| -> |res| ->
      ----------------------------
  """
  def test4(chan) do
    stream = Hello.Stub.say_hello4(chan)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 1), end_stream: false)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 2), end_stream: false)
    GRPC.Stub.send_request(stream, ReqHello.new(a: 3), end_stream: true)
    {:ok, res_stream} = GRPC.Stub.recv(stream)
    Enum.each(res_stream, &IO.inspect(&1, label: "client got res"))
  end
end

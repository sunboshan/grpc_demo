defmodule Hello.Server do
  use GRPC.Server, service: Hello.Service

  def say_hello1(%ReqHello{a: a}, _stream) do
    ResHello.new(a: a * a)
  end

  def say_hello2(req_stream, _stream) do
    Enum.each(req_stream, &IO.inspect(&1, label: "server got req"))
    ResHello.new(a: 1)
  end

  def say_hello3(_req, stream) do
    GRPC.Server.send_reply(stream, ResHello.new(a: 1))
    GRPC.Server.send_reply(stream, ResHello.new(a: 2))
    GRPC.Server.send_reply(stream, ResHello.new(a: 3))
  end

  def say_hello4(req_stream, stream) do
    Enum.each(req_stream, fn %ReqHello{a: a} = req ->
      IO.inspect(req, label: "server got req")
      GRPC.Server.send_reply(stream, ResHello.new(a: a * a))
    end)
  end
end

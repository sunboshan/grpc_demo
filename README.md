# GRPC demo

The simplest GRPC demo.

## Setup

```
$ brew install protobuf
$ mix escript.install hex protobuf
```

## Usage

```
$ iex -S mix

iex(1)> chan = GRPCDemo.connect()
%GRPC.Channel{
  adapter: GRPC.Adapter.Gun,
  adapter_payload: %{conn_pid: #PID<0.225.0>},
  cred: nil,
  host: "127.0.0.1",
  port: 9527,
  scheme: "http"
}

iex(2)> GRPCDemo.test1(chan)
1

iex(3)> GRPCDemo.test2(chan)
server got req: %ReqHello{a: 1}
server got req: %ReqHello{a: 2}
server got req: %ReqHello{a: 3}
1

iex(4)> GRPCDemo.test3(chan)
client got res: {:ok, %ResHello{a: 1}}
client got res: {:ok, %ResHello{a: 2}}
client got res: {:ok, %ResHello{a: 3}}
:ok

iex(5)> GRPCDemo.test4(chan)
server got req: %ReqHello{a: 1}
server got req: %ReqHello{a: 2}
server got req: %ReqHello{a: 3}
client got res: {:ok, %ResHello{a: 1}}
client got res: {:ok, %ResHello{a: 4}}
client got res: {:ok, %ResHello{a: 9}}
:ok
```

## Diagram

```
  rpc say_hello1(ReqHello) returns (ResHello);

  One request, one response.

      server         client
      ---------------------
       <- |req|
                  |res| ->
      ---------------------

==================================================================

  rpc say_hello2(stream ReqHello) returns (ResHello);

  Stream requests, one response.

      server                client
      ----------------------------
       <- |req| <- |req| <- |req|
                |res| ->
      ----------------------------

==================================================================

  rpc say_hello3(ReqHello) returns (stream ResHello);

  One request, stream responses.

      server                client
      ----------------------------
                <- |req|
       |res| -> |res| -> |res| ->
      ----------------------------

==================================================================

  rpc say_hello4(stream ReqHello) returns (stream ResHello);

  Stream requests, stream responses.

      server                client
      ----------------------------
       <- |req| <- |req| <- |req|
       |res| -> |res| -> |res| ->
      ----------------------------
```

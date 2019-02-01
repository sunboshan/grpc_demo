defmodule ReqHello do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          a: integer
        }
  defstruct [:a]

  field :a, 1, type: :int32
end

defmodule ResHello do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          a: integer
        }
  defstruct [:a]

  field :a, 1, type: :int32
end

defmodule Hello.Service do
  @moduledoc false
  use GRPC.Service, name: "Hello"

  rpc :say_hello1, ReqHello, ResHello
  rpc :say_hello2, stream(ReqHello), ResHello
  rpc :say_hello3, ReqHello, stream(ResHello)
  rpc :say_hello4, stream(ReqHello), stream(ResHello)
end

defmodule Hello.Stub do
  @moduledoc false
  use GRPC.Stub, service: Hello.Service
end

proto:
	@protoc --elixir_out=plugins=grpc:. lib/proto/hello.proto

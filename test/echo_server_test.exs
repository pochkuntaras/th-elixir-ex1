defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  setup do
    pid = EchoServer.start()

    {:ok, %{pid: pid}}
  end

  test "ping", %{pid: pid} do
    assert {:pong, :nonode@nohost} == EchoServer.ping(pid)
  end
end

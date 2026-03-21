defmodule EchoServer do
  @moduledoc """
  The echo server receives a ping message and sends back a pong with the node address.
  """

  @doc """
  Starts the echo server and return its ID.

  ## Examples
      iex> pid = EchoServer.start()
      ...> is_pid(pid)
  """
  @spec start :: pid()
  def start, do: spawn(&loop/0)

  @doc """
  Sends a synchronous to the server and and return a response.

  ## Examples
      iex> pid = EchoServer.start()
      ...> "Hello" = EchoServer.call(pid, "Hello")
  """
  @spec call(pid(), any()) :: {:pong,atom()} | any()
  def call(pid, request) do
    send(pid, {:call, request, self()})

    receive do
      {:ok, response} -> response
    end
  end

  @doc """
  Sends a `:ping` request and returns `{:pong, node()}`.

  ## Examples
      iex> pid = EchoServer.start()
      ...> {:pong, :nonode@nohost} == EchoServer.ping(pid)
  """
  @spec ping(pid()) :: {:pong, atom()}
  def ping(pid), do: call(pid, :ping)

  defp loop do
    receive do
      {:call, :ping, pid} -> send(pid, {:ok, {:pong, node()}})
      {:call, request, pid} -> send(pid, {:ok, request})
    end

    loop()
  end
end

defmodule GenEchoServer do
  @moduledoc """
  The echo server receives a ping message and sends back a pong with the node address.
  """

  use GenServer

  @doc """
  Starts the echo server and return its `{:ok, pid}`.

  ## Examples
      iex> {:ok, pid} = GenEchoServer.start()
      ...> is_pid(pid)
  """
  @spec start() :: :ignore | {:error, any()} | {:ok, pid()}
  def start do
    GenServer.start(__MODULE__, nil)
  end

  @doc """
  Sends a `:ping` request and returns `{:pong, node()}`.

  ## Examples
      iex> {:ok, pid} = GenEchoServer.start()
      ...> {:pong, :nonode@nohost} == GenEchoServer.ping(pid)
  """
  @spec ping(GenServer.server()) :: {:pong, atom()}
  def ping(server) do
    GenServer.call(server, :ping)
  end

  @impl GenServer
  @spec init(any()) :: {:ok, any()}
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl GenServer
  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end
end

# The Echo Server

## Development

```bash
mix deps.get
mix compile
mix test

iex -S mix
```

## Example

```elixir
pid = EchoServer.start()
EchoServer.ping(pid)

{:ok, pid} = GenEchoServer.start()
GenEchoServer.ping(pid)
```

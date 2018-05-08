# shutdown_flag

This application waits for a flag file to appear, then initiates a graceful shutdown
by calling `:init.stop()`. See [the Erlang man page](http://erlang.org/doc/man/init.html#stop-0).

The purpose is to allow new releases of the app to be deployed and the app
restarted without the deployer needing permissions to run e.g. `systemctl
restart`.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `shutdown_flag` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:shutdown_flag, "~> 0.1.0"}
  ]
end
```

## Configuration

```elixir
config :shutdown_flag,
  flag_file: "/tmp/shutdown_flag/restart.txt",
  check_delay: 10_000
```

`flag_file` specifies the path to the flag file. Default is `/tmp/shutdown_flag/restart.txt`.
Note that the user account that the app is running under needs to have file system permissions
to delete this file, or there will be a restart loop. The app will shutdown, then get restarted,
see the file, then shutdown, get restarted, and so on. 

`check_delay` specfies how often, in milliseconds, to check for the file. Default is 10s.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/shutdown_flag](https://hexdocs.pm/shutdown_flag).

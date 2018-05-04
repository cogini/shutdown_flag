defmodule ShutdownFlag.Worker do
  @moduledoc "Trigger system shutdown based on flag file"
  @app :shutdown_flag
  @default_check_delay 10_000
  @default_flag_file "/tmp/shutdown_flag/restart.txt"

  use GenServer
  require Logger

  @doc "Start the server"
  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end
  def start_link(args, opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  # GenServer callbacks

  def init(_args) do
    Process.send_after(self(), :check, check_delay())
    {:ok, %{}}
  end

  def handle_info(:check, state) do
    flag_file = flag_file()
    # Logger.debug("Checking file #{flag_file}")
    case File.stat(flag_file) do
      {:ok, _stat} ->
        Logger.info("Shutting down")
        delete_file(flag_file)
        :init.stop()
        {:stop, :normal, state}
      {:error, _reason} ->
        Process.send_after(self(), :check, check_delay())
        {:noreply, state}
    end
  end

  @spec delete_file(Path.t) :: :ok
  defp delete_file(path) do
    Logger.debug("Deleting file #{path}")
    case File.rm(path) do
      :ok ->
        :ok
      {:error, :enoent} ->
        :ok
      {:error, reason} ->
        Logger.error("Error deleting file #{path}: #{reason}")
        :ok
    end
  end

  # doc "Duration to wait before checking for file"
  @spec check_delay() :: non_neg_integer
  defp check_delay do
    Application.get_env(@app, :check_delay, @default_check_delay)
  end

  # doc "Path to flag file"
  @spec flag_file() :: Path.t
  defp flag_file do
    Application.get_env(@app, :flag_file, @default_flag_file)
  end
end

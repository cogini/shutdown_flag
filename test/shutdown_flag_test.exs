defmodule ShutdownFlagTest do
  use ExUnit.Case
  doctest ShutdownFlag

  test "greets the world" do
    assert ShutdownFlag.hello() == :world
  end
end

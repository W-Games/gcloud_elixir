defmodule GcloudElixirTest do
  use ExUnit.Case
  doctest GcloudElixir

  test "greets the world" do
    assert GcloudElixir.hello() == :world
  end
end

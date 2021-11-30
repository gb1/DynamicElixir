defmodule DynTest do
  use ExUnit.Case
  doctest Dyn

  test "greets the world" do
    assert Dyn.hello() == :world
  end
end

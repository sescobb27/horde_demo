defmodule HordesDemoTest do
  use ExUnit.Case
  doctest HordesDemo

  test "greets the world" do
    assert HordesDemo.hello() == :world
  end
end

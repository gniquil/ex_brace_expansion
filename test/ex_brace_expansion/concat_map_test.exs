defmodule ConcatMapTest do
  use ExUnit.Case, async: true

  import ExBraceExpansion.ConcatMap

  test "empty or not" do
    assert concat_map([1,2,3,4,5,6], fn val ->
      if rem(val, 2) == 0 do
        []
      else
        [val - 0.1, val, val + 0.1]
      end
    end) == [ 0.9, 1, 1.1, 2.9, 3, 3.1, 4.9, 5, 5.1 ]
  end

  test "always something" do
    assert concat_map(["a", "b", "c", "d"], fn val ->
      if val == "b" do
        ["B", "B", "B"]
      else
        [val]
      end
    end) == [ "a", "B", "B", "B", "c", "d" ]
  end

  test "scalar" do
    assert concat_map(["a", "b", "c", "d"], fn val ->
      if val == "b" do
        ["B", "B", "B"]
      else
        val
      end
    end) == [ "a", "B", "B", "B", "c", "d" ]
  end

  test "nils" do
    assert concat_map(["a", "b", "c", "d"], fn _ -> end) == [ nil, nil, nil, nil ]
  end
end

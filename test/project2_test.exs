defmodule Project2Test do
  use ExUnit.Case
  doctest Project2

  test "greets the world" do
    assert Project2.hello() == :world
  end

  test "reverse list" do
    assert Project2.reverse_list([1, 2, 3]) == [3, 2, 1]
  end

  test "map" do
    assert Project2.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end

  test "filter" do
    assert Project2.filter([1, 2, 3], fn x -> x > 1 end) == [2, 3]
  end

  test "reduce" do
    assert Project2.reduce([1, 2, 3]) == 6
  end

  test "parallel map" do
    list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    function = fn x -> x * 2 end;
    assert Project2.parallel_map(list, function) == Project2.map(list, function)
  end

  test "btree" do
    tree = Project2.Tree.new(10) |> Project2.Tree.insert(11) |> Project2.Tree.insert(9) |> Project2.Tree.insert(8)

    assert tree == %Project2.Tree { value: 10, children: [%Project2.Tree { value: 9, children: [%Project2.Tree { value: 8 }, :right] }, %Project2.Tree { value: 11 }] }
  end

  test "linked list" do
    tree = Project2.LinkedList.new(10) |> Project2.LinkedList.insert(11)

    assert tree == %Project2.LinkedList { value: 10, next: %Project2.LinkedList { value: 11 } }
  end
end

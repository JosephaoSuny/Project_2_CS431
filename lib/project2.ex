defmodule Project2 do
  defmodule Tree do
    defstruct value: nil, children: [:left, :right]

    def new(v) do
      %Tree { value: v }
    end

    def insert(:right, e) do
      %Tree { value: e }
    end

    def insert(:left, e) do
      %Tree { value: e }
    end

    def insert(%Tree{value: v, children: [left, right]}, e) do
      case v do
        nil -> %Tree { value: e, children: [left, right] }
        v when v > e -> %Tree { value: v, children: [insert(left, e), right] }
        v -> %Tree { value: v, children: [left, insert(right, e)] }
      end
    end
  end

  defmodule LinkedList do
    defstruct value: nil, next: nil

    def new(v) do
      %LinkedList { value: v }
    end

    def insert(%LinkedList { value: v, next: next }, elm) do
      case next do
        nil -> %LinkedList { value: v, next: %LinkedList { value: elm } }
        list -> %LinkedList { value: v, next: insert(list, elm) }
      end
    end
  end

  @moduledoc """
  Documentation for `Project2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Project2.hello()
      :world

  """
  def hello do
    :world
  end

  def reverse_list_helper(list, acc) do
    case list do
      [hd | tl] -> reverse_list_helper(tl, acc) ++ acc ++ [hd]
      [] -> acc
    end
  end

  def reverse_list(list) do
    acc = reverse_list_helper(list, [])
    acc
  end

  def map(list, function) do
    case list do
      [hd | tl] -> [function.(hd)] ++ map(tl, function)
      [] -> []
    end
  end

  def filter(list, function) do
    case list do
      [hd | tl] -> if function.(hd) do [hd] ++ filter(tl, function) else filter(tl, function) end
      [] -> []
    end
  end

  def reduce(list) do
    case list do
      [hd | tl] when [] != tl -> hd + reduce(tl)
      [hd | []] -> hd
      [] -> raise "Cannot reduce empty list"
    end
  end

  @doc """
  Maps elements of the list, and executes the functions in parallel
  """
  @spec parallel_map(list(), any()) :: list()
  def parallel_map(list, fun) do
    tasks = map(list, fn x -> Task.async(fn -> fun.(x) end) end)
    Task.await_many(tasks)
  end
end

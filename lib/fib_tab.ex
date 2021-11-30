defmodule FibTab do
  def run do
    fib(100)
    |> Enum.at(100)
  end

  def fib(n) do
    table =
      for _ <- 0..n do
        0
      end
      |> List.insert_at(1, 1)

    Enum.reduce(0..n, table, fn x, acc ->
      value = Enum.at(acc, x)

      acc
      |> List.update_at(x + 1, &(&1 + value))
      |> List.update_at(x + 2, &(&1 + value))
    end)
  end
end

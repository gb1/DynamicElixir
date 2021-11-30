defmodule BestSum do
  def run do
    Agent.start_link(fn -> %{} end, name: :cache)
    IO.inspect(best_sum(7, [5, 3, 4, 7]), charlists: :as_lists)
    IO.inspect(best_sum(8, [2, 3, 5]))
    IO.inspect(best_sum(8, [1, 4, 5]))
    IO.inspect(best_sum(100, [1, 2, 5, 25]))
  end

  def best_sum(target, numbers) do
    cond do
      Agent.get(:cache, &Map.has_key?(&1, target)) ->
        Agent.get(:cache, &Map.get(&1, target))

      target == 0 ->
        []

      target < 0 ->
        nil

      true ->
        Enum.reduce(numbers, %{}, fn number, acc ->
          remainder = target - number
          result = best_sum(remainder, numbers)

          if result != nil do
            path = Map.get(acc, target)

            cond do
              path == nil ->
                Map.put(acc, target, [number | result])

              length(path) > length([number | result]) ->
                Agent.update(:cache, &Map.put(&1, target, [number | result]))
                Map.put(acc, target, [number | result])

              true ->
                acc
            end
          else
            acc
          end
        end)
        |> Map.get(target)
    end
  end
end

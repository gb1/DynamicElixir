defmodule Howsum do
  def sum(target_sum, number) do
    Agent.start_link(fn -> %{} end, name: :cache)
    do_sum(target_sum, number)
  end

  defp do_sum(0, _numbers), do: []
  defp do_sum(target_sum, _numbers) when target_sum < 0, do: nil

  defp do_sum(target_sum, numbers) do
    if Agent.get(:cache, &Map.has_key?(&1, target_sum)) do
      Agent.get(:cache, &Map.get(&1, target_sum))
    else
      Enum.find_value(numbers, fn number ->
        remainder = target_sum - number
        result = do_sum(remainder, numbers)
        Agent.update(:cache, &Map.put(&1, remainder, result))

        if result != nil do
          [number | result]
        end
      end)
    end
  end
end

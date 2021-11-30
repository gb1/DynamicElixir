defmodule HowSum do
  def run do
    cache()
    # sum(300, [7, 15], [])
    sum(7, [5, 3, 4, 7], [])
  end

  def cache do
    Agent.start_link(fn -> nil end, name: :solution)
    Agent.start_link(fn -> %{} end, name: :cache)
  end

  @doc """
  Can you make target_sum from numbers list
  You can use individual numbers as many times as you like
  """
  def sum(0, _numbers, _), do: []
  def sum(target_sum, _numbers, _) when target_sum < 0, do: nil

  def sum(target_sum, numbers, path) do
    if Agent.get(:cache, &Map.has_key?(&1, target_sum)) do
      Agent.get(:cache, &Map.get(&1, target_sum))
    else
      solution = Agent.get(:solution, & &1)

      if !solution do
        for number <- numbers do
          remainder = target_sum - number
          result = sum(remainder, numbers, path ++ [number])
          Agent.update(:cache, &Map.put(&1, remainder, result))

          if result == [] do
            Agent.update(:solution, &(&1 = path ++ [number]))
          end
        end
      end
    end

    Agent.get(:solution, & &1)
  end
end

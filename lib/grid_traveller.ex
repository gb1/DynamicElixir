defmodule GridTraveller do
  def cache do
    Agent.start_link(fn -> %{} end, name: :cache)
  end

  @doc """
  How many ways to travel from one corner of
  a m x n grid to the opposite corner?
  """
  def traveller(m, n) do
    cached_value = Agent.get(:cache, &Map.get(&1, {m, n}))

    cond do
      cached_value ->
        cached_value

      m == 1 and n == 1 ->
        1

      m == 0 or n == 0 ->
        0

      true ->
        answer = traveller(m - 1, n) + traveller(m, n - 1)
        Agent.update(:cache, &Map.put(&1, {m, n}, answer))
        answer
    end
  end
end

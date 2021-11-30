defmodule Fib do
  def cache do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: :cache)
  end

  def fib(n) do
    cached_value = Agent.get(:cache, &Map.get(&1, n))

    if cached_value do
      cached_value
    else
      answer = fib(n - 1) + fib(n - 2)
      Agent.update(:cache, &Map.put(&1, n, answer))
      answer
    end
  end
end

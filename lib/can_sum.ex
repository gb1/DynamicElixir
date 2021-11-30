defmodule CanSum do
  def cache do
    Agent.start_link(fn -> MapSet.new() end, name: :cache)
  end

  @doc """
  Can you make target_sum from numbers list
  You can use individual numbers as many times as you like
  """
  def can_sum(0, _numbers), do: true
  def can_sum(target_sum, _numbers) when target_sum < 0, do: false

  def can_sum(target_sum, numbers) do
    if Agent.get(:cache, &MapSet.member?(&1, target_sum)) do
      false
    else
      numbers
      |> Enum.reduce_while(false, fn number, _ ->
        remainder = target_sum - number

        cond do
          can_sum(remainder, numbers) ->
            {:halt, true}

          true ->
            if remainder > 0 do
              Agent.update(:cache, &MapSet.put(&1, remainder))
            end

            {:cont, false}
        end
      end)
    end
  end
end

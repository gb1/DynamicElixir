defmodule Hanoi do
  def run do
    hanoi(:a, :b, :c, 3)
  end

  def hanoi(start, temp, destination, n) do
    if n == 1 do
      IO.puts("Move from #{start} to #{destination}")
    else
      IO.puts("boop")
      # move n-1 discs from the start to the temp via the target
      hanoi(start, destination, temp, n - 1)
      # move bottom disc from the start to the target
      hanoi(start, temp, destination, 1)
      # move n-1 discs from the temp to the target via the start
      hanoi(temp, start, destination, n - 1)
    end
  end
end

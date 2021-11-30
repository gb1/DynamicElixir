defmodule Mix.Tasks.Go do
  use Mix.Task

  def run(_) do
    BestSum.run()
  end
end

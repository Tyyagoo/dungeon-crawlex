defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_), do: CLI.Main.start_game()
end

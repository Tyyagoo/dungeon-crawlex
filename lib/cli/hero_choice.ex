defmodule CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell
  import CLI.BaseCommands

  def start() do
    Shell.cmd("clear")
    Shell.info("Start by choosing your hero:")

    heroes = DungeonCrawl.Heroes.all()

    heroes
    |> ask_for_index()
    |> confirm_hero()
  end

  defp confirm_hero(hero) do
    Shell.cmd("clear")
    Shell.info(hero.description)
    if Shell.yes?("Confirm?"), do: hero, else: start()
  end
end

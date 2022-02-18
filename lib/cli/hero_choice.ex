defmodule CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("Start by choosing your hero:")
    heroes = DungeonCrawl.Heroes.all()
    find_hero_by_index = &Enum.at(heroes, &1)

    heroes
    |> Enum.map(& &1.name)
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parse_input()
    |> find_hero_by_index.()
    |> confirm_hero()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "Which one? [#{options}]\n"
  end

  defp parse_input(input) do
    case Integer.parse(input) do
      {number, _} -> number - 1
      _ -> 0
    end
  end

  defp confirm_hero(hero) do
    Shell.cmd("clear")
    Shell.info(hero.description)
    if Shell.yes?("Confirm?"), do: hero, else: start()
  end
end

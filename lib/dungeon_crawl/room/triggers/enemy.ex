defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias DungeonCrawl.{Battle, Character}
  alias DungeonCrawl.Room.Action
  alias Mix.Shell.IO, as: Shell

  @spec is_alive(Character.t()) :: Macro.t()
  defguard is_alive(c) when c.hit_points > 0

  @spec is_both_alive(Character.t(), Character.t()) :: Macro.t()
  defguard is_both_alive(c1, c2) when is_alive(c1) and is_alive(c2)

  def run(character, %Action{id: :battle}) do
    Battle.random_start(character)
    |> show_message()
    |> step()
    |> case do
      %Character{hit_points: 0} -> {:death, nil}
      updated_character -> {:foward, updated_character}
    end
  end

  defp step(%Battle{player: player, enemy: enemy} = battle) when is_both_alive(player, enemy) do
    Process.sleep(150)

    battle
    |> Battle.simulate()
    |> show_message()
    |> step()
  end

  defp step(%Battle{player: player}) do
    Shell.prompt("The battle is over... One side has no more life.")
    player
  end

  defp show_message(%Battle{message: message} = battle) do
    Shell.info(message)
    battle
  end
end

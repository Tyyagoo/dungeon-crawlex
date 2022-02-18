defmodule DungeonCrawl.Room.Triggers.Trap do
  @behaviour DungeonCrawl.Room.Trigger

  alias DungeonCrawl.Character
  alias DungeonCrawl.Room.Action
  alias Mix.Shell.IO, as: Shell

  def run(character, %Action{id: :forward}) do
    Shell.info("You're walking cautiously and can see the next room.")
    {:forward, character}
  end

  def run(character, %Action{id: :search}) do
    damage = 3

    Shell.info("You search the room looking for something useful.")
    Shell.info("You step on a false floor and fall into a trap.")
    Shell.info("You are hit by an arrow, losing #{damage} hit points.")

    case Character.take_damage(character, 3) do
      # only the score matters when character dies
      %Character{hit_points: 0} -> {:death, character}
      updated_character -> {:forward, updated_character}
    end
  end
end

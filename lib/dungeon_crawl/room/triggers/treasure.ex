defmodule DungeonCrawl.Room.Triggers.Treasure do
  @behaviour DungeonCrawl.Room.Trigger

  alias DungeonCrawl.Character
  alias DungeonCrawl.Room.Action
  alias Mix.Shell.IO, as: Shell

  def run(character, %Action{id: :forward}) do
    {:forward, character}
  end

  def run(character, %Action{id: :search}) do
    healing = 5

    Shell.info("You search the room looking for something useful.")
    Shell.info("You find a treasure box with a healing potion inside.")
    Shell.info("You drink the potion and restore #{healing} hit points.")

    {:forward, Character.heal(character, healing)}
  end
end

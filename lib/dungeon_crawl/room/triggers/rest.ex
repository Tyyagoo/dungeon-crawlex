defmodule DungeonCrawl.Room.Triggers.Rest do
  @behaviour DungeonCrawl.Room.Trigger

  alias DungeonCrawl.Character
  alias DungeonCrawl.Room.Action
  alias Mix.Shell.IO, as: Shell

  def run(character, %Action{id: :forward}) do
    Shell.info("You're walking cautiously and can see the next room.")
    {:forward, character}
  end

  def run(character, %Action{id: :rest}) do
    healing = 3

    Shell.info("You search the room for a comfortable place to rest.")
    Shell.info("After a little rest you regain #{healing} hit points.")

    {:forward, Character.heal(character, healing)}
  end
end

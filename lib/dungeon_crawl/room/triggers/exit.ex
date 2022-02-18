defmodule DungeonCrawl.Room.Triggers.Exit do
  @behaviour DungeonCrawl.Room.Trigger

  def run(character, _), do: {:exit, character}
end

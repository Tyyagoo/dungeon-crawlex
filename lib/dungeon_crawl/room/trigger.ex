defmodule DungeonCrawl.Room.Trigger do
  alias DungeonCrawl.Character
  alias DungeonCrawl.Room.Action
  @callback run(character :: Character.t(), action :: Action.t()) :: {atom(), Character.t()}
end

defmodule DungeonCrawl.Room do
  alias __MODULE__
  alias DungeonCrawl.Room.{Action}
  alias DungeonCrawl.Room.Triggers

  defstruct description: nil, actions: [], trigger: nil

  @type t :: %Room{description: String.t(), actions: list(Action.t()), trigger: Trigger}

  def all(),
    do: [
      %Room{
        description: "You can see the light of day. You found the exit!",
        actions: [Action.forward()],
        trigger: Triggers.Exit
      },
      %Room{
        description: "You found a quiet place. Looks safe for a little nap.",
        actions: [Action.forward(), Action.rest()]
      }
    ]
end

defmodule DungeonCrawl.Room do
  alias __MODULE__
  alias DungeonCrawl.Room.{Action}
  alias DungeonCrawl.Room.Triggers

  defstruct description: nil, actions: [], trigger: nil

  @type t :: %Room{description: String.t(), actions: list(Action.t()), trigger: Trigger}

  @exit_room %{
    description: "You can see the light of day. You found the exit!",
    actions: [Action.forward()],
    trigger: Triggers.Exit
  }

  @enemy_room %{
    description: "You can see an enemy blocking your path.",
    actions: [Action.battle()],
    trigger: Triggers.Enemy
  }

  @normal_room %{
    description: "You found a quiet place. Looks safe for a little nap.",
    actions: [Action.forward(), Action.rest()]
  }

  def all(), do: [@exit_room, @enemy_room, @normal_room] |> Enum.map(&struct(Room, &1))
end

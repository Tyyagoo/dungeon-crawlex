defmodule DungeonCrawl.Room do
  alias __MODULE__
  alias DungeonCrawl.Room.{Action, Trigger, Triggers}

  defstruct description: nil, actions: [], trigger: nil

  @type t :: %Room{description: String.t(), actions: list(Action.t()), trigger: Trigger}

  def all(player_score) do
    normal = generate_multiple_rooms(normal_room(), 10)
    enemy = generate_multiple_rooms(enemy_room(), 14)
    treasure = generate_multiple_rooms(treasure_room(), 4)
    trap = generate_multiple_rooms(trap_room(), 4)
    exit_ = generate_multiple_rooms(exit_room(), player_score * 1)

    [normal, enemy, treasure, trap, exit_]
    |> Enum.concat()
    |> Enum.shuffle()
  end

  defp generate_multiple_rooms(room, quantity) do
    [room]
    |> Stream.cycle()
    |> Enum.take(quantity)
  end

  defp normal_room() do
    %Room{
      description: "You found a quiet place. Looks safe for a little nap.",
      actions: [Action.forward(), Action.rest()],
      trigger: Triggers.Rest
    }
  end

  defp enemy_room() do
    %Room{
      description: "You can see an enemy blocking your path.",
      actions: [Action.battle()],
      trigger: Triggers.Enemy
    }
  end

  defp treasure_room() do
    %Room{
      description: "Oh? this room looks different...\nMaybe there are secrets hidden there.",
      actions: [Action.forward(), Action.search()],
      trigger: Triggers.Treasure
    }
  end

  defp trap_room() do
    %Room{
      description: "Oh? this room looks different...\nMaybe there are secrets hidden there.",
      actions: [Action.forward(), Action.search()],
      trigger: Triggers.Trap
    }
  end

  defp exit_room() do
    %Room{
      description: "You can see the light of day. You found the exit!",
      actions: [Action.forward()],
      trigger: Triggers.Exit
    }
  end
end

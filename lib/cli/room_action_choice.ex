defmodule CLI.RoomActionChoice do
  alias Mix.Shell.IO, as: Shell
  alias DungeonCrawl.Room
  import CLI.BaseCommands

  def start(%Room{description: desc, actions: acts} = room) do
    Shell.info(desc)

    acts
    |> ask_for_index()
    |> pack(room)
  end

  defp pack(action, room), do: {room, action}
end

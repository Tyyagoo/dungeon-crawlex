defmodule CLI.RoomActionChoice do
  alias Mix.Shell.IO, as: Shell
  alias DungeonCrawl.Room
  import CLI.BaseCommands

  def start(%Room{description: desc, actions: acts} = room) do
    find_action_by_index = &Enum.at(acts, &1)
    Shell.info(desc)

    acts
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parse_input()
    |> find_action_by_index.()
    |> pack(room)
  end

  defp pack(action, room), do: {room, action}
end

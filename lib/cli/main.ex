defmodule CLI.Main do
  alias Mix.Shell.IO, as: Shell
  alias CLI.{HeroChoice, RoomActionChoice}

  def start_game() do
    welcome_message()

    Shell.prompt("Press Enter to continue")

    HeroChoice.start()
    |> crawl(DungeonCrawl.Room.all())
  end

  defp welcome_message() do
    Shell.info("== Dungeon Crawl ===")
    Shell.info("You awake in a dungeon full of monsters.")
    Shell.info("You need to survive and find the exit.")
  end

  defp crawl(character, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")

    rooms
    |> Enum.random()
    |> RoomActionChoice.start()
    |> trigger_action(character)
    |> handle_action_result()
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({:exit, _}),
    do: Shell.info("You found the exit. You won the game. Congratulations!")

  defp handle_action_result({_, character}), do: crawl(character, DungeonCrawl.Room.all())
end

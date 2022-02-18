defmodule CLI.Main do
  alias Mix.Shell.IO, as: Shell
  alias CLI.{HeroChoice, RoomActionChoice}

  def start_game() do
    welcome_message()

    Shell.prompt("Press Enter to continue")

    HeroChoice.start()
    DungeonCrawl.Room.all() |> crawl()
  end

  defp welcome_message() do
    Shell.info("== Dungeon Crawl ===")
    Shell.info("You awake in a dungeon full of monsters.")
    Shell.info("You need to survive and find the exit.")
  end

  defp crawl(rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")

    rooms
    |> Enum.random()
    |> RoomActionChoice.start()
  end
end

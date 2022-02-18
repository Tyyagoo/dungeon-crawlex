defmodule CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def ask_for_index(options) do
    options
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> Integer.parse()
    |> case do
      {index, _} -> handle_valid_integer(options, index - 1)
      _ -> handle_invalid_integer(options)
    end
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "Which one? [#{options}]\n> "
  end

  defp handle_valid_integer(options, index) when index >= 0 do
    Enum.at(options, index) || handle_invalid_integer(options)
  end

  defp handle_valid_integer(options, _) do
    handle_invalid_integer(options)
  end

  defp handle_invalid_integer(options) do
    display_invalid_option()
    ask_for_index(options)
  end

  defp display_invalid_option() do
    Shell.cmd("clear")
    Shell.error("Invalid option.")
    Process.sleep(10)
    Shell.prompt("Press Enter to try again.")
    Shell.cmd("clear")
  end
end

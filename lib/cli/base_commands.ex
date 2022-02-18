defmodule CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  @invalid_option {:error, "Invalid option."}

  def ask_for_index(options) do
    maybe_integer =
      options
      |> display_options()
      |> generate_question()
      |> Shell.prompt()

    with {:ok, index} <- parse_integer(maybe_integer),
         {:ok, option} <- find_option_by_index(options, index) do
      option
    else
      {:error, message} ->
        display_invalid_option(message)
        ask_for_index(options)
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

  defp parse_integer(maybe_integer) do
    maybe_integer
    |> Integer.parse()
    |> case do
      {number, _} -> {:ok, number - 1}
      _ -> @invalid_option
    end
  end

  defp find_option_by_index(options, index) when index >= 0 do
    options
    |> Enum.at(index)
    |> case do
      nil -> @invalid_option
      option -> {:ok, option}
    end
  end

  defp find_option_by_index(_, _) do
    @invalid_option
  end

  defp display_invalid_option(message) do
    Shell.cmd("clear")
    Shell.error(message)
    Process.sleep(10)
    Shell.prompt("Press Enter to try again.")
    Shell.cmd("clear")
  end
end

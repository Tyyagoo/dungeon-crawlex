defmodule DungeonCrawl.Room.Action do
  alias __MODULE__
  defstruct id: nil, label: nil

  @type t :: %Action{id: atom(), label: String.t()}

  def forward(), do: %Action{id: :forward, label: "Move forward."}
  def rest(), do: %Action{id: :rest, label: "Take a better look and rest."}
  def search(), do: %Action{id: :search, label: "Search the room."}
  def battle(), do: %Action{id: :battle, label: "Fight for your life."}

  defimpl String.Chars do
    def to_string(action), do: action.label
  end
end

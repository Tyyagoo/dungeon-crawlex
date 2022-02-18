defmodule DungeonCrawl.Character do
  alias __MODULE__

  defstruct name: nil,
            description: nil,
            hit_points: 0,
            max_hit_points: 0,
            attack_description: nil,
            damage_range: nil

  @type t :: %Character{
          name: String.t(),
          description: String.t(),
          hit_points: non_neg_integer(),
          max_hit_points: non_neg_integer(),
          attack_description: String.t(),
          damage_range: Range.t()
        }

  @spec take_damage(character :: t(), amount :: non_neg_integer()) :: t()
  def take_damage(%Character{hit_points: hp} = char, amount) do
    new_hp = max(0, hp - amount)
    %Character{char | hit_points: new_hp}
  end

  @spec heal(character :: t(), amount :: non_neg_integer()) :: t()
  def heal(%Character{hit_points: hp, max_hit_points: max_hp} = char, amount) do
    new_hp = min(hp + amount, max_hp)
    %Character{char | hit_points: new_hp}
  end

  @spec status(character :: t()) :: String.t()
  def status(%Character{name: name, hit_points: hp, max_hit_points: max_hp}) do
    "#{name} status -> HP: #{hp}/#{max_hp}"
  end

  defimpl String.Chars do
    def to_string(character), do: character.name
  end
end

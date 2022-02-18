defmodule DungeonCrawl.Battle do
  alias __MODULE__
  alias DungeonCrawl.{Character, Enemies}

  defstruct player: nil, enemy: nil, message: nil, attacker: :player

  @type t :: %Battle{
          player: Character.t(),
          enemy: Character.t(),
          message: String.t(),
          attacker: :player | :enemy
        }

  @spec random_start(player :: Character.t()) :: t()
  def random_start(player) do
    enemy = Enemies.all() |> Enum.random()
    start(player, enemy)
  end

  @spec start(player :: Character.t(), enemy :: Character.t()) :: t()
  def start(player, enemy) do
    %Battle{
      player: player,
      enemy: enemy,
      message: "#{player} just started a fight with an #{enemy}"
    }
  end

  @spec simulate(battle :: t()) :: t()
  def simulate(%Battle{player: player, enemy: enemy, attacker: :player}) do
    dmg = player.damage_range |> Enum.random()
    updated_enemy = enemy |> Character.take_damage(dmg)
    message = generate_message(player, updated_enemy, dmg)

    %Battle{player: player, enemy: updated_enemy, attacker: :enemy, message: message}
  end

  def simulate(%Battle{player: player, enemy: enemy, attacker: :enemy}) do
    dmg = enemy.damage_range |> Enum.random()
    updated_player = player |> Character.take_damage(dmg)
    message = generate_message(enemy, updated_player, dmg)

    %Battle{player: updated_player, enemy: enemy, attacker: :player, message: message}
  end

  @spec generate_message(
          attacker :: Character.t(),
          target :: Character.t(),
          damage :: non_neg_integer()
        ) :: String.t()
  def generate_message(attacker, target, damage) do
    "#{attacker.name} attacks with #{attacker.attack_description} and deal #{damage} damage.\n#{target |> Character.status()}"
  end
end

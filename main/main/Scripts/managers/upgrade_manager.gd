class_name UpgradeDistributor extends Node

@export var coin_manager: CoinManager
@export var player: CharacterBody2D

func _on_upgrade_recive(upgrade: Upgrade):
	match upgrade.upgrade_id:
		"luck":
			coin_manager._update_luck(10)
		"speed":
			player._update_movement_speed(30)
		"spawn":
			coin_manager._update_spawn_rate(-1)

class_name MainMenuCoinSpawner extends Node

const FALLING_COIN_SCENE = preload("res://main/Scenes/main_menu/main_menu_falling_coin.tscn")

const SPAWN_TIME = 0.4

@export var coin_collection: Node2D

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = SPAWN_TIME
	timer.timeout.connect(_spawn_coin)
	timer.start()


func _spawn_coin():
	var random_x_pos = randf() * 1152
	
	var falling_gold = FALLING_COIN_SCENE.instantiate()
	coin_collection.add_child(falling_gold)
	falling_gold.position.x = random_x_pos

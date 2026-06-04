class_name CoinManager extends Node

const GOLD_SCENE = preload("res://playfield_module/Scenes/gold.tscn")

signal gold_picked_up(value: int)

@export var spawn_rate: float = 5
@export var luck: float = 0.1

@export var min_spawn: Vector2
@export var max_spawn: Vector2

@export var gold_collection: Node2D

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_rate
	timer.timeout.connect(_spawn_gold)
	timer.start()


func _spawn_gold():
	var random_x = randi_range(min_spawn.x, max_spawn.x)
	var random_y = randi_range(min_spawn.y, max_spawn.y)
	var random_pos: Vector2i = Vector2i(random_x, random_y)
	
	var coin_type: Gold = DropCalculator.get_random_item(luck)
	var gold = GOLD_SCENE.instantiate()
	gold.item_type = coin_type
	gold_collection.add_child(gold)
	gold.item_picked_up.connect(_gold_picked_up)
	
	
	gold.position = Vector2(random_pos)


func _gold_picked_up(gold_value: int):
	gold_picked_up.emit(gold_value)


func _update_luck(bonus: float):
	var new_rate = luck + bonus
	luck = maxf(new_rate, 0.1)


func _update_spawn_rate(bonus: float):
	var new_rate = spawn_rate + bonus
	spawn_rate = maxf(new_rate, 0.5)
	timer.wait_time = spawn_rate

	timer.start()

class_name ItemDrop extends Node2D

signal item_picked_up(gold_type: int)

@onready var sprite = $Sprite2D
@onready var pickup_area = $Area2D

var item_type: Gold

func _ready():
	if item_type:
		sprite.texture = item_type.gold_sprite
		pickup_area.area_entered.connect(_on_pickup)


func _on_pickup(area: Area2D) -> void:
	if area.name == "PickupArea":
		item_picked_up.emit(item_type.value)
		
		queue_free()

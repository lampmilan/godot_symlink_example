extends Sprite2D


const POSSIBLE_TEXTURE: Array[Texture2D] = [
	preload("res://shared/Assets/golds/small.png"),
	preload("res://shared/Assets/golds/medium.png"),
	preload("res://shared/Assets/golds/large.png")
]

func _ready() -> void:
	texture = POSSIBLE_TEXTURE.pick_random()

func _physics_process(delta: float) -> void:
	position.y += 150 * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "DeleteArea2D":
		queue_free()

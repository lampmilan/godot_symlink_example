extends CharacterBody2D

@export var speed: float = 300.0
@export var sprite_child: AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 and direction.y != 0:
		if abs(direction.x) >= abs(direction.y):
			direction.y = 0
		else:
			direction.x = 0
		
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed 
		
		if direction.x > 0:
			sprite_child.play("walk_left")
		elif direction.x < 0:
			sprite_child.play("walk_right")
		elif direction.y > 0:
			sprite_child.play("walk_down")
		elif direction.y < 0:
			sprite_child.play("walk_up")
			
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		sprite_child.play("default")
	
	move_and_slide()


func _update_movement_speed(bonus: float):
	speed += bonus

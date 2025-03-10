extends CharacterBody2D

const SPEED = 300.0
var bullet = preload("res://scenes/bullet.tscn")

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	direction = Input.get_axis("top", "down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	look_at(get_global_mouse_position())
	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		fire()

func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = global_position
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.direction = Vector2.RIGHT.rotated(rotation)
	get_tree().get_root().add_child(bullet_instance)

func kill():
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "enemy" in body.name:
			kill()

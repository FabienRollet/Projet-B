extends CharacterBody2D

const SPEED = 300.0
var bullet = preload("res://scenes/bullet.tscn")
var dir : Vector2

func _unhandled_input(event: InputEvent) -> void:
	dir.x =Input.get_axis("left","right")
	dir.y = Input.get_axis("top","down")
	dir = dir.normalized()


func _physics_process(_delta: float) -> void:
	velocity = dir * SPEED
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

extends CharacterBody2D

const SPEED = 300.0
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	if player == null:
		print("Player is not assigned!")
		return

	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	look_at(player.position)
	move_and_slide()

func makepath() -> void:
	if player == null:
		print("Player is not assigned!")
		return

	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makepath()

func kill():
	queue_free()

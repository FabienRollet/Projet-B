extends CharacterBody2D

const SPEED = 100.0
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	makepath()

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		body.kill()

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	makepath()

func kill():
	queue_free()

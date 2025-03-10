extends Area2D

var speed = 2000
var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	var velocity = direction * speed * delta
	global_position += velocity


func _on_body_entered(body: Node2D) -> void:
	if "enemy" in body.name:
		body.kill()
		queue_free()
	elif body.name != "player":
		queue_free()

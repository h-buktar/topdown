extends CharacterBody2D


const SPEED = 300.0

var target = null

func _physics_process(delta: float) -> void:

	move_and_slide()


func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
 

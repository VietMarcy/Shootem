extends RigidBody2D

export var speed = 400
var dmg = 10
export var rotated_angle = 0

func _ready():
	apply_impulse(Vector2(), Vector2(speed,0).rotated(rotated_angle))
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()





func _on_Area2D_body_entered(body):
	if body.name== "Player1":
		body.hit(dmg)
		queue_free()



func _on_Timer_timeout():
	queue_free()

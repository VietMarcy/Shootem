extends RigidBody2D

export var speed = 400
var damage = 100
export var rotated_angle = 0

func _ready():
	apply_impulse(Vector2(), Vector2(speed,0).rotated(rotated_angle))


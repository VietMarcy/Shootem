extends KinematicBody2D

var character = Vector2()
var movespeed = 200
var jump= 3.5
var gravity = 0.2
var nextstar = 0
var shoot = preload("res://Bullet.tscn")
onready var player = $Icon
onready var health = 100


func _physics_process(delta):
	character.x =Input.get_action_strength("right") - Input.get_action_strength("left")
	if Input.is_action_pressed("left"):
		player.scale.x=-1
	if Input.is_action_pressed("right"):
		player.scale.x = 1
			
	if Input.is_action_just_pressed("jump")and is_on_floor():
		character.y -= jump
	var movement = movespeed * character * delta
	move_and_collide(movement)
	#character.y += gravity + delta
	character = move_and_slide(character, Vector2.UP)
	$arm.look_at(get_global_mouse_position())
	shoot()
 
func shoot():
	if Input.is_action_pressed("LMB"):
		var bullet_ins = shoot.instance()
		bullet_ins.position = $arm/gun/muzzle.position
		bullet_ins.rotation_degrees=$arm.rotation_degrees
		bullet_ins.rotated_angle = $arm.rotation
		$arm/gun/muzzle.get_tree().current_scene.add_child(bullet_ins)
		add_collision_exception_with(self)

func hit(dmg):
	health -= dmg
	if health > 0:
		pass
	else:
		queue_free()
		death()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	death()


	
func death():
	get_tree().reload_current_scene()


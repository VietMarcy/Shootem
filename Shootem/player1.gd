extends KinematicBody2D

var character = Vector2()
var movespeed = 200
var climbspeed=1
var jump= 3.5
var gravity = 0.2
var nextstar = 0
var shoot = preload("res://Bullet.tscn")
var nextshot = 0
var reload = 400
var ladder = false
onready var Player = $Player1
onready var health = 100
onready var tween = $Tween
puppet var puppet_pos = Vector2(0,0) setget puppet_pos_set
puppet var puppet_vel = Vector2()
puppet var puppet_rot = 0


func _physics_process(delta):
	if is_network_master():
		character.x =Input.get_action_strength("right") - Input.get_action_strength("left")
		if Input.is_action_pressed("left"):
			Player.scale.x=-1
			$Player1.play("Walk")
		if Input.is_action_pressed("right"):
			$Player1.play("Walk")
		Player.scale.x = 1
		if Input.is_action_just_released("left"):
			$Player1.play("default")
		if Input.is_action_just_released("right"):
			$Player1.play("default")
		if Input.is_action_just_pressed("jump")and is_on_floor():
			character.y -= jump
			$Player1.play("jump")
		$arm.look_at(get_global_mouse_position())
		if ladder==true:
			gravity = 0
			if Input.is_action_pressed("climb"):
				character.y = -climbspeed
			elif Input.is_action_pressed("climbdown"):
				character.y = climbspeed
		if ladder == false:
			gravity =.2
	else:
		rotation_degrees = lerp(rotation_degrees, puppet_rot, delta*8)
		
		if not tween.is_active():
			move_and_slide(puppet_vel * movespeed)
	var movement = movespeed * character * delta
	move_and_collide(movement)
	character.y += gravity + delta
	character = move_and_slide(character, Vector2.UP)
	shoot()


 
func shoot():
	if Input.is_action_pressed("LMB"):
		var now = OS.get_ticks_msec()
		if now >= nextshot:
			var bullet_ins = shoot.instance()
			bullet_ins.position = $arm/gun/muzzle.global_position
			bullet_ins.rotation_degrees=$arm.rotation_degrees
			bullet_ins.rotated_angle = $arm.rotation
			$arm/gun/muzzle.get_tree().current_scene.add_child(bullet_ins)
			bullet_ins.add_collision_exception_with(self)
			nextshot = now + reload
			


func hit(dmg):
	health -= dmg
	$Player1.play("Hurt")
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






func _on_Player1_animation_finished():
	$Player1.play("default")

func puppet_pos_set(new_value) -> void:
	puppet_pos = new_value
	
	tween.interpolate_property(self, "global_position", global_position, puppet_pos, 0,1)
	tween.start()

func _on_time_timeout():
	if is_network_master():
		rset_unreliable("puppet_pos", global_position)
		rset_unreliable("puppet_rot", rotation_degrees)
		rset_unreliable("puppet_vel", movespeed)

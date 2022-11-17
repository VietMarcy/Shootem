extends KinematicBody2D

var character = Vector2()
var movespeed = 200
var aimspeed = 100
var climbspeed=1
var jump= 3.5
var gravity = 0.2
var nextstar = 0
var shoot = preload("res://bullet2.tscn")
var nextshot = 0
var reload = 400
var ladder = false
onready var Player = $Player2
onready var health = 100
onready var reticle = $Reticle
onready var tween = $Tween
puppet var puppet_pos = Vector2(0,0) setget puppet_pos_set
puppet var puppet_vel = Vector2()
puppet var puppet_rot = 0

func _physics_process(delta):
	if is_network_master():
		character.x =Input.get_action_strength("right2") - Input.get_action_strength("left2")
		if Input.is_action_pressed("left2"):
			Player.scale.x= 1
			$Player2.play("walk")
		if Input.is_action_pressed("right2"):
			$Player2.play("walk")
			Player.scale.x = -1
		if Input.is_action_just_released("left2"):
			$Player2.play("default")
		if Input.is_action_just_released("right2"):
			$Player2.play("default")
		if Input.is_action_just_pressed("jump2")and is_on_floor():
			character.y -= jump
			$Player2.play("jump")
		if ladder==true:
			gravity = 0
			if Input.is_action_pressed("climb2"):
				character.y = -climbspeed
			elif Input.is_action_pressed("climbdown2"):
				character.y = climbspeed
		if ladder == false:
			gravity =.2
			$arm.look_at(get_global_mouse_position())
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
	if Input.is_action_pressed("LMB2"):
		var now = OS.get_ticks_msec()
		if now >= nextshot:
			var bullet_ins = shoot.instance()
			bullet_ins.position = $arm/gun/muzzle.global_position
			bullet_ins.rotation_degrees=$arm.rotation_degrees
			bullet_ins.rotated_angle = $arm.rotation
			$arm.get_tree().current_scene.add_child(bullet_ins)
			bullet_ins.add_collision_exception_with(self)
			nextshot = now + reload
			


func hit(dmg):
	health -= dmg
	$Player2.play("hurt")
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


func _on_Player2_animation_finished():
	$Player2.play("default")
	
func puppet_pos_set(new_value) -> void:
	puppet_pos = new_value
	
	tween.interpolate_property(self, "global_position", global_position, puppet_pos, 0,1)
	tween.start()

func _on_time_timeout():
	if is_network_master():
		rset_unreliable("puppet_pos", global_position)
		rset_unreliable("puppet_rot", rotation_degrees)
		rset_unreliable("puppet_vel", movespeed)

extends Area2D

func _on_Ladders_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true
	if body.name == "Player2":
		get_node("../Player2").ladder=true


func _on_Ladders_body_exited(body):
	if body.name == "Player1":
		get_node(("../Player1")).ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false



func _on_Ladders4_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true
	if body.name == "Player2":
		get_node("../Player2").ladder=true


func _on_Ladders4_body_exited(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false


func _on_Ladders3_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true
	if body.name == "Player2":
		get_node("../Player2").ladder=true


func _on_Ladders3_body_exited(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false


func _on_Ladders_2_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true

	if body.name == "Player2":
		get_node("../Player2").ladder=true

func _on_Ladders_2_body_exited(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false

func _on_Ladders5_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true
	if body.name == "Player2":
		get_node("../Player2").ladder=true

func _on_Ladders5_body_exited(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false

func _on_Ladders2_body_entered(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=true
	if body.name == "Player2":
		get_node("../Player2").ladder=true

func _on_Ladders2_body_exited(body):
	if body.name == "Player1":
		get_node("../Player1").ladder=false
	if body.name == "Player2":
		get_node("../Player2").ladder=false

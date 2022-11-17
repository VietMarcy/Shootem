extends Control

var player = load("res://Player.tscn")
var player2 = load("res://Player 2.tscn")

onready var multiplayerui = $multiconfig
onready var serverip = $multiconfig/server

onready var device_ip =  $CanvasLayer/Label


func _ready():
	get_tree().connect("player_connected",self,"player_connected")
	get_tree().connect("player_disconnected",self,"player_disconnected")
	get_tree().connect("server_joined",self,"joined_server")
	
	device_ip.text = Network.ip_adress
	
func _player_connected(id) -> void:
	print("player" +str(id)+ "has connected")
	instance_player(id)

func _player_disconnected(id) -> void:
	print("player" +str(id)+ "has disconnected")
	if Players.has_node(str(id)):
		Players.get_node(str(id)).queue_free()

func _on_Create_pressed():
	get_tree().change_scene("res://Level 1.tscn")
	Network.create_server()
	
	instance_player(get_tree().get_network_unique_id())

func _on_Join_pressed():
	if serverip.text != "":
		get_tree().change_scene("res://Level 1.tscn")
		Network.ip_address = serverip.text
		Network.join_server()

func _connected_to_server() -> void:
	yield(get_tree().create_timer(0,1), "timeout")
	instance_player2(get_tree().get_network_unique_id())

func instance_player(id) -> void:
	var player_instance = Globe.instance_node_at_location(player,Players, Vector2(rand_range(0,50),rand_range(0,1)))
	player_instance.set_network_master(id)
	
func instance_player2(id) -> void:
	var player2_instance = Globe.instance_node_at_location(player,Players, Vector2(rand_range(0,1060),rand_range(0,1)))
	player2_instance.set_network_master(id)

extends Node

const DEFAULT_PORT = 29960
const MAX_CLIENTS = 2

var server = null
var client = null

var ip_adress = ""

func _ready() -> void:
	if OS.get_name() == "Windows":
		ip_adress = IP.get_local_addresses()[3]
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_adress =ip
	
	get_tree().connect("connected",self,"connected")
	get_tree().disconnect("disconnected",self,"disconnected")
	
func create_server() -> void:
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)

func _conncected_to_server() -> void:
	print("successfully connected")
	
func _server_disconnected() -> void:
	print("disconnected from server")

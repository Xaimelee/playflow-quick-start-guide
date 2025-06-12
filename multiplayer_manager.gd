extends Node

#ENetMultiplayerPeer
@onready var peer = WebSocketMultiplayerPeer.new()

func _ready() -> void:
	if is_server():
		pass

func start_server() -> void:
	var err: Error = peer.create_server(8080)
	if err == 0:
		multiplayer.multiplayer_peer = peer

func start_client(address: String) -> void:
	#wss:// if web exported or server uses ssl, otherwise you can use ws://
	var err: Error = peer.create_client("wss://" + address)
	if err == 0:
		multiplayer.multiplayer_peer = peer

func is_server() -> bool:
	return OS.has_feature("dedicated_server")

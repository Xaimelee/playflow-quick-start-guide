extends Node

# Internal server port
const PORT: int = 8080

#Use ENetMultiplayerPeer for non web games
@onready var peer = WebSocketMultiplayerPeer.new()

func _ready() -> void:
	# The server should always automatically start
	if is_server():
		start_server()

func start_server() -> void:
	var err: Error = peer.create_server(PORT)
	if err == 0:
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func start_client(url: String, port: String) -> void:
	# wss:// if web exported or server uses ssl, otherwise you can use ws://
	# If you want to use localhost (i.e you run a windows server export on your PC for testing), then it must be ws:// instead.
	var err: Error = peer.create_client("wss://" + url + ":" + port)
	# ENet: var err: Error = peer.create_client("wss://" + ip, int(port))
	if err == 0:
		multiplayer.multiplayer_peer = peer

func disconnect_from_server() -> void:
	peer.close()

func is_server() -> bool:
	# Exports have tags and this lets us identify if the build is a dedicated server.
	return OS.has_feature("dedicated_server")

func _on_peer_disconnected(id: int) -> void:
	var nodes = get_tree().get_nodes_in_group("Player")
	for node in nodes:
		if node.get_multiplayer_authority() == id:
			node.queue_free()
			break

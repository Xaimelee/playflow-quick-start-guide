extends MultiplayerSpawner

func _ready() -> void:
	spawn_function = spawn_player
	# We only want the server spawning new players when new peers connect
	if MultiplayerManager.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)

func spawn_player(peer_id: int) -> Node:
	var player: Node = load(get_spawnable_scene(0)).instantiate()
	player.set_multiplayer_authority(peer_id)
	return player

func _on_peer_connected(id: int) -> void:
	spawn(id)

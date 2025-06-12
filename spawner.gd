extends MultiplayerSpawner

func _ready() -> void:
	spawn_function = spawn_player
	# We only want the server spawning new players
	if MultiplayerManager.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)

func spawn_player(peer_id: int) -> Node:
	var player: Node = load("uid://djb6140cph0dy").instantiate()
	# This is not server authoritative
	player.set_multiplayer_authority(peer_id)
	return player

func _on_peer_connected(id: int) -> void:
	spawn(id)

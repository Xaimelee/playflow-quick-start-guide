extends Node3D

@export var speed: float = 5.0

func _process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var offset: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * speed * delta
	translate(offset)

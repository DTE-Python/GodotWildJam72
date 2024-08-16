extends RayCast3D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var hitObj = get_collider()
		if hitObj.has_method("PlayerInteraction") && Input.is_action_just_pressed("interact"):
			hitObj.PlayerInteraction()

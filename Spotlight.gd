extends Node3D

signal body_entered(body)
signal body_exited(body)

@export var area:Area3D
@export var light:SpotLight3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	emit_signal("body_entered", body)


func _on_area_3d_body_exited(body):
	emit_signal("body_exited", body)
	
func _set_on_off(is_on:bool):
	light.visible = is_on
	area.monitoring = is_on
	
func _toggle_on_off():
	light.visible = not light.visible
	area.monitoring = light.visible
	
func _set_on():
	_set_on_off(true)

func _set_off():
	_set_on_off(false)

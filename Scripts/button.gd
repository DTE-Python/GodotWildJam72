extends Node3D

signal body_entered
signal body_exited

@export var ButtonID: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	emit_signal("body_entered", ButtonID)


func _on_area_3d_body_exited(body):
	emit_signal("body_exited", ButtonID)

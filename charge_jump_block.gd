extends RigidBody3D


var start_time = 0
var elapsed_time = 0

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_height = 5.0

var release_time = 0

var antigrav = 0
var held = false
var start_height = 0
var light_charge = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(4)
	release_time = Time.get_unix_time_from_system()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_height = get_transform().origin.y
	var current_time = Time.get_unix_time_from_system()
	var target_height = (max_height + start_height) - current_height
	
	if held and current_height < target_height:
		light_charge += 0.01
	else:
		light_charge -= 0.01
	
	if light_charge <= 0:
		light_charge = 0
	elif light_charge >= 1:
		light_charge = 1
	
	if light_charge > 0:
		if held:
			apply_central_force(Vector3(0, 0, 0))
		else:
			apply_central_force(Vector3.UP * gravity * target_height)
			
	for collision in get_colliding_bodies():
		if "floor" in collision.name.to_lower():
			start_height = current_height


func _input(event):
	pass


func _on_player_body_entered(body):
	if body == self:
		held = true


func _on_player_body_exited(body):
	if body == self:
		held = false

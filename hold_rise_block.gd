extends RigidBody3D


var start_time = 0
var elapsed_time = 0

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_height = 5.0
@export var float_speed = 1
# I looked at some resources on water buoyancy
# using drag on linear velocity is how we get it to hold in the air
# Increasing these values will make it stop faster or slower 
@export var drag = 0.1
@export var angular_drag = 0.05

@export var hold_time = 5.0

var release_time = 0

var held = false
var start_height = 0
var hold_pos = false

var default_linear_velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(2)
	release_time = Time.get_unix_time_from_system()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_height = get_transform().origin.y
	var current_time = Time.get_unix_time_from_system()
	var target_height = (max_height + start_height) - current_height
	
	if held and not hold_pos:
		if current_height < target_height:
			apply_central_force(Vector3.UP * gravity * target_height * float_speed)
			default_linear_velocity = linear_velocity
		else:
			hold_pos = true
			
	if hold_pos:
		apply_central_force(Vector3.UP * gravity * target_height * float_speed)
		linear_velocity  *= 1 - drag
		linear_velocity *= 1 - angular_drag
		print(current_time - release_time)

	if current_time - release_time >= hold_time and not held:
		hold_pos = false
		linear_velocity = -default_linear_velocity


	for collision in get_colliding_bodies():
		if "floor" in collision.name:
			start_height = current_height


func _input(event):
	# This will be replaced by the raycast
	if event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_T:
				held = true
		if event.is_released():
			if event.keycode == KEY_T:
				release_time = Time.get_unix_time_from_system()
				held = false


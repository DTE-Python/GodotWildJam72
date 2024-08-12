extends CharacterBody3D
@export var camera:Camera3D
@export var flashlight:SpotLight3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var jumping = false
var can_jump = 0
@export_range(0,0.1) var SENSITIVITY = 0.05

@export var flashlightArea:Area3D

signal body_entered
signal body_exited

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*SENSITIVITY)
		camera.rotate_x(-event.relative.y*SENSITIVITY)
		camera.rotation.x = clampf(camera.rotation.x,-PI/2,PI/2)
		
	
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta #* 1.01 if velocity.y>0 else 1
		
	if is_on_floor():
		can_jump = 10
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump>0:
		velocity.y = JUMP_VELOCITY
		jumping = true
		can_jump = 0
	if jumping and !Input.is_action_pressed("jump") and velocity.y>0:
		jumping = false
		velocity.y = 0


	if Input.is_action_just_pressed("flashlight"):
		flashlight.visible = !flashlight.visible
		flashlightArea.monitoring = flashlight.visible
		
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	can_jump-=1
	move_and_slide()
	
	#if abs(velocity.y) < abs(get_platform_velocity().y):
		#velocity = get_platform_velocity()
	


func _on_area_3d_body_entered(body):
	emit_signal("body_entered", body)


func _on_area_3d_body_exited(body):
	emit_signal("body_exited", body)

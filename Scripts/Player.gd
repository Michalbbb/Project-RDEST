extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.001
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8 #ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
#@onready var camera = $Head/SpringArm3D/Camera3D
@onready var player = $"."
#@onready var surface = $"../CSGBox3D"						


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_x(-event.relative.y * SENSITIVITY)
		player.rotate_y(-event.relative.x * SENSITIVITY)
		#print(rad_to_deg(head.get_global_position().angle_to(surface.get_global_position())))
		#if rad_to_deg(camera.get_position().angle_to(surface.get_position())) > 90:
			#print("test")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Quitting game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if Input.is_action_pressed("sprint") and is_on_floor():
			velocity.x = 2 * velocity.x
			velocity.z = 2 * velocity.z
	else:
		velocity.x = 0.0 #move_toward(velocity.x, 0, SPEED)
		velocity.z = 0.0 #move_toward(velocity.z, 0, SPEED)

	move_and_slide()

extends CharacterBody3D

const SPEED = 5.0 # 5.0 default
const JUMP_VELOCITY = 9 #4.5 default
const SENSITIVITY = 0.001
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8 #ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
@onready var player = $"."
@onready var anim_tree = $CollisionShape3D/PhMainHero2/AnimationTree
#@onready var minimap_border = $"../GUI/SubViewportContainer/Minimap_border"
@onready var HoodedNpcAnimation = $"../StaticBody3D/CollisionShape3D/HoodedNpc/AnimationPlayer2"
var captured=1;
var lastSpeedX = 0;
var lastSpeedZ = 0;
#ground_level 
var ground_level = [0,0]
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	HoodedNpcAnimation.get_animation("Waiting")
	HoodedNpcAnimation.play("Waiting")

func _unhandled_input(event):
	if event is InputEventMouseMotion and captured==1:
		head.rotate_x(-event.relative.y * SENSITIVITY)
		player.rotate_y(-event.relative.x * SENSITIVITY)
		#minimap_border.rotate(-event.relative.x * SENSITIVITY)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	# menu
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#Free or capture mouse
	if Input.is_action_just_pressed("ChangeMouseStance"):
		if captured==1: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			captured=0;
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			captured=1;
	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var dirLight=$"../WorldEnvironment/DirectionalLight3D"
	if Global.shadow == 1: 
		dirLight.shadow_enabled=true
	# Reset character position
	if player.position.y <= ground_level[1]:
		player.position.x = 0
		player.position.y = 0
		player.position.z = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if Input.is_action_pressed("sprint"):
			if Global.currentStamina > 0 :
				Global.currentStamina-=20*delta
				velocity.x = 10 * velocity.x
				velocity.z = 10 * velocity.z
			
	else:
		velocity.x = 0.0 #move_toward(velocity.x, 0, SPEED)
		velocity.z = 0.0 #move_toward(velocity.z, 0, SPEED)
	if !Input.is_action_pressed("sprint") :
		Global.currentStamina+=20*delta*Global.staminaRegenPerSec*Global.increasedStaminaRecoveryRate;
		if Global.currentStamina>Global.maxStamina: Global.currentStamina=Global.maxStamina
	if !is_on_floor():
		velocity.x=lastSpeedX
		velocity.z=lastSpeedZ
	lastSpeedX=velocity.x;
	lastSpeedZ=velocity.z;
	anim_tree.set("parameters/blend_position",velocity.length()/SPEED)
	move_and_slide()


func _on_button_north_pressed():
	self.position = Global.North
	pass # Replace with function body.


func _on_button_east_pressed():
	self.position = Global.East
	pass # Replace with function body.


func _on_button_west_pressed():
	self.position = Global.West
	pass # Replace with function body.

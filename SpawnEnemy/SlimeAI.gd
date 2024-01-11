extends Node3D

@onready var target
var isTargetSet=false
@onready var slime = $RigidBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	var animationPlayer= $RigidBody3D/CollisionShape3D/Slime2/AnimationPlayer2
	animationPlayer.get_animation("walk")
	animationPlayer.play("walk")
	_setPosition()
func _setPosition():
	slime.position.x=-572
	slime.position.y=130
	slime.position.z=-457

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

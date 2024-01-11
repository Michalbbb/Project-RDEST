extends Node3D

@onready var target
var isTargetSet=false
@onready var slime = $RigidBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	var animationPlayer= $RigidBody3D/CollisionShape3D/Slime2/AnimationPlayer2
	animationPlayer.get_animation("walk")
	animationPlayer.play("walk")
	_setPosition(randi_range(-600,-200),randi_range(-600,-200))
func _setPosition(x,z):
	slime.position.x=x
	slime.position.y=130
	slime.position.z=z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

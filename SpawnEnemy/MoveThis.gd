extends RigidBody3D
@onready var animation=$CollisionShape3D/Slime2/AnimationPlayer2
@onready var body = $"."
@onready var timer = $"../AttackDuration"
@onready var attackCooldown = $"../AttackCooldown"
@onready var checkHits = $"../HitMoment"
var isInAttackRange=false
var isAttacking=false
var enemySpotted = false
var isAttackOnCooldown= false
var playerCanBeHit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func attack():
	animation.get_animation("attackSlime")
	animation.play("attackSlime")
	timer.start()
	checkHits.start()
	isAttacking=true
	isAttackOnCooldown=true

func _integrate_forces(state):
	if isAttacking: return
	var target_vector = global_position.direction_to(Global.targetForMonsters.position)
	var target_basis= Basis.looking_at(target_vector)
	basis = basis.slerp(target_basis, 0.5)
	var distanceFromPlayerX= abs(abs(Global.targetForMonsters.position.x)-abs(body.position.x))
	var distanceFromPlayerZ= abs(abs(Global.targetForMonsters.position.z)-abs(body.position.z))
	var velocity = state.get_linear_velocity()
	if Global.isPlayerReady and distanceFromPlayerX < 20 and distanceFromPlayerZ < 20:
		enemySpotted=true;
	if enemySpotted:
		if distanceFromPlayerX>5 or distanceFromPlayerZ>5:
			if Global.targetForMonsters.position.x-body.position.x <0:
				velocity.x = -3
			else:
				velocity.x= 3
			if Global.targetForMonsters.position.z-body.position.z <0:
				velocity.z = -3
			else:
				velocity.z=3
		else:
			if isAttackOnCooldown: 
				velocity.x=0
				velocity.z=0
			else:
				attack()
	else:
		velocity.x=0
		velocity.z=0
	if Global.targetForMonsters.position.y > body.position.y:
		velocity.y=3
	elif Global.targetForMonsters.position.y+1> body.position.y:
		velocity.y = 0
	else:
		velocity.y=-3
	state.set_linear_velocity(velocity)


func _on_timer_timeout():
	isAttacking=false
	animation.play("walk")
	attackCooldown.start()


func _on_timer_2_timeout():
	isAttackOnCooldown=false



func _on_area_3d_body_entered(body):
	if body == Global.targetForMonsters :
		playerCanBeHit=true


func _on_area_3d_body_exited(body):
	if body == Global.targetForMonsters :
		playerCanBeHit=false


func _on_hit_moment_timeout():
	if playerCanBeHit: Global.dealDmgToPlayer(randi_range(2,5),0,0,randi_range(6,10),0)

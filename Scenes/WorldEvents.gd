extends Node3D

var enemy_list = preload("res://SpawnEnemy/SpawnSlime.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 5:
		var enemy = enemy_list.instantiate()
		add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

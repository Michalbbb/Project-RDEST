extends Control

@onready var inv: Inv = preload("res://Inventory/PlayerInv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _process(delta):
	if Global.EQoppened == true:
		open()
	else:
		close()

func open():
	self.visible = true
	is_open = true

func close():
	visible = false
	is_open = false

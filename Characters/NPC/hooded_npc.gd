extends Node3D

@onready var popup = $QuestWindow
var is_popup_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu") and !Global.isGameScreenClear:
		_on_quest_window_close_requested()


func _on_interactable_focused(interactor):
	pass # Replace with function body.


func _on_interactable_interacted(interactor):
	if not is_popup_open:
		Global.isMouseCaptured=false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		popup.show()
		is_popup_open = true
		Global.isGameScreenClear=false


func _on_interactable_unfocused(interactor):
	_on_quest_window_close_requested()


func _on_quest_window_close_requested():
	popup.hide()
	is_popup_open = false
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isGameScreenClear=true

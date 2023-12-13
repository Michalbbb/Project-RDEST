extends Node3D

@onready var popup = $FastTravelWindow
var is_popup_open = false
@onready var this_position = position
# Called when the node enters the scene tree for the first time.
func _ready():
	#print(this_position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu") and !Global.isGameScreenClear:
		_on_fast_travel_window_close_requested()

# Called when object enters interactable distance
func _on_interactable_focused(interactor):
	pass

# Called when object is interacted with
func _on_interactable_interacted(interactor):
	if not is_popup_open:
		Global.isMouseCaptured=false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		popup.show()
		is_popup_open = true
		Global.isGameScreenClear=false

# Called when object exits interactable distance
func _on_interactable_unfocused(interactor):
	popup.hide()
	is_popup_open = false
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isGameScreenClear=true

# Handling closing of the window
func _on_fast_travel_window_close_requested():
	popup.hide()
	is_popup_open = false
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isGameScreenClear=true

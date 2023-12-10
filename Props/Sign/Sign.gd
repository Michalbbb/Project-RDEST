extends Node3D

@onready var popup = $FastTravelWindow
var is_popup_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when object enters interactable distance
func _on_interactable_focused(interactor):
	pass

# Called when object is interacted with
func _on_interactable_interacted(interactor):
	if not is_popup_open:
		popup.show()
		is_popup_open = true

# Called when object exits interactable distance
func _on_interactable_unfocused(interactor):
	popup.hide()
	is_popup_open = false

# Handling closing of the window
func _on_fast_travel_window_close_requested():
	popup.hide()
	is_popup_open = false

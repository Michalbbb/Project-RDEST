extends Area3D

class_name Interactable

# Emitted when an Interactor starts looking at me.
signal focused(interactor: Interactor)
# Emitted when an Interactor stops looking at me.
signal unfocused(interactor: Interactor)
# Emitted when an Interactor interacts with me.
signal interacted(interactor: Interactor)


func _on_focused(interactor):
	pass # Replace with function body.


func _on_interacted(interactor):
	pass # Replace with function body.


func _on_unfocused(interactor):
	pass # Replace with function body.


func _on_quest_window_close_requested():
	pass # Replace with function body.

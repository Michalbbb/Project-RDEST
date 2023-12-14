extends StaticBody3D
# Called when the node enters the scene tree for the first time.
@onready var dialog = $"../DialogWindow"
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu") and !Global.isGameScreenClear and Global.isDialogOpen:
		_close_dialog()
	
func _on_interactable_interacted(interactor):
	if !Global.isDialogOpen:
		if Global.hoodedNpcTakenMissions==0:
			var newCoordZ=RandomNumberGenerator.new().randi_range(-200,200)+$".".position.z
			var newCoordX=RandomNumberGenerator.new().randi_range(-200,200)+$".".position.x
			var options = ["Sure, tell me where you left that manual.","I will be fine on my own."]
			var stages = ["[center][b]First Meeting[/b][/center]\nHooded one left his manual at position (x,z)("+str(int(newCoordX))+","+str(int(newCoordZ))+") go and find it.","[center][b]First Meeting[COMPLETED][/b][/center]\nYou found manual and learned from it. It seems like your body is in much better shape."]
			dialog._assign_quest("First meeting","New face in this damned place? Well, you can call me \"Hooded One\" or whatever you like since all of us will rot in this place. Anyway you don't look so well, so what about I'll tell you where I left manual for technique that my squad used. It will dramatically improve your stamina and allow your body to be recovering much faster.",options,stages,"HOODEDNPC",newCoordX,newCoordZ)
		if Global.hoodedNpcTakenMissions==1:
			var options = ["Nothing in particular.","Just wanted to say hello."]
			var stages = ["NULL"]
			dialog._assign_quest("Greetings","Hello, do you need something?",options,stages,"HOODEDNPC",0,0)
		dialog.show()
		Global.isGameScreenClear=false
		Global.isMouseCaptured=false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Global.isDialogOpen=true


# Called when object exits interactable distance
func _on_interactable_unfocused(interactor):
	dialog.hide()
	Global.isGameScreenClear=true
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isDialogOpen=false
# Handling closing of the window

func _on_interactable_focused(interactor):
	pass
func _close_dialog():
	dialog.hide()
	Global.isGameScreenClear=true
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isDialogOpen=false

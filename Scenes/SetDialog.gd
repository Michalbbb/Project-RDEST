extends TextureRect

@onready var dialog = $"."
@onready var titleOfQuest = $Title
@onready var contentOfQuest = $Content
@onready var possibleOptions = [$OptionA,$OptionB,$OptionC]
@onready var HUD = $"../UI/Node2D"
var questInJourney=[]
var fromWho=""
var coords
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _assign_quest(title,content,options,quest,type,coordX,coordZ):
	titleOfQuest.text=title
	contentOfQuest.text=content
	var howManyOptions = options.size()
	for index in howManyOptions:
		possibleOptions[index].show()
		possibleOptions[index].text=options[index]
	questInJourney=quest
	fromWho=type
	coords=Vector2(coordX,coordZ)


func _on_option_a_pressed():
	
	Global.isGameScreenClear=true
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isDialogOpen=false
	if questInJourney[0] != "NULL" : 
		HUD._addQuestToJourney(questInJourney,coords)
		Global.addToLog("You accepted mission. Coordinates(x,z): "+str(int(coords.x))+","+str(int(coords.y))+")")
		if fromWho=="HOODEDNPC":
			Global.hoodedNpcTakenMissions+=1
	dialog.hide()


func _on_option_b_pressed():
	
	Global.isGameScreenClear=true
	Global.isMouseCaptured=true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.isDialogOpen=false
	dialog.hide()

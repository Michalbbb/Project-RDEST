extends Control


# Called when the node enters the scene tree for the first time.
@onready var drop_down_menu=$ResolutionSize
@onready var ds_mode=$DisplayMode
var resolutions=[Vector2i(1280,720),Vector2i(1440,1080),Vector2i(1600,900),Vector2i(1980,1080), Vector2i(3440, 1440)]
func _ready():
	add_items_resolution()
	add_items_display_mode()

func add_items_resolution():
	drop_down_menu.add_item("1280x720")
	drop_down_menu.add_item("1440x1080")
	drop_down_menu.add_item("1600x900")
	drop_down_menu.add_item("1980x1080")
	drop_down_menu.add_item("3440x1440")
	drop_down_menu.selected=Global.chosenResolution
func add_items_display_mode():
	ds_mode.add_item("Window mode")
	ds_mode.add_item("Borderless Window")
	ds_mode.add_item("Fullscreen")
	ds_mode.add_item("Borderless Full-screen")
	ds_mode.selected=Global.chosenMode

func _on_option_button_item_selected(index):

	get_viewport().size = resolutions[index]
	Global.chosenResolution=index


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_display_mode_item_selected(index):
	Global.chosenMode=index
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _on_shadow_button_pressed():
	var thisButton=$ShadowButton;
	if Global.shadow == 0 :
		Global.shadow = 1
		thisButton.text="ENABLED"
	else:
		Global.shadow=0
		thisButton.text="DISABLED"
		
		
		
	

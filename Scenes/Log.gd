extends RichTextLabel

@onready var Log=$"."
# Called when the node enters the scene tree for the first time.
func _ready():
	Log.text=Global.log


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Log.text=Global.log

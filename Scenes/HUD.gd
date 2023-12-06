extends Node2D

@onready var hpBar = $HpBar/HpLabel
@onready var staminaBar = $StaminaBar/StaminaLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	hpBar.text=str(Global.currentHp)+" / "+str(Global.maxHp)
	$HpBar.value=int((Global.currentHp*100)/Global.maxHp);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hpBar.text=str(Global.currentHp)+" / "+str(Global.maxHp)
	$HpBar.value=int((Global.currentHp*100)/Global.maxHp);
	$StaminaBar.value=int((Global.currentStamina*100)/Global.maxStamina);
	
	


func _on_timer_timeout():
	Global.regenPool+=Global.regenPerSec*Global.increasedLifeRecovery
	if Global.regenPool > 1:
		Global.currentHp+=int(Global.regenPool)
		Global.regenPool-=int(Global.regenPool)
		if Global.currentHp>Global.maxHp:
			Global.currentHp=Global.maxHp
		

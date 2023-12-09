extends Node2D

@onready var hpBar = $HpBar/HpLabel
@onready var staminaBar = $StaminaBar/StaminaLabel

@onready var InventoryBar = $TextureButton
@onready var InventoryMenu  = $InventoryRect
var k1=false

@onready var JournalBar = $TextureButton2
@onready var JournalMenu  = $JournalRect
var k2 = false 
@onready var CharacterBar = $TextureButton3
@onready var CharacterMenu  = $CharacterRect
var k3 =false
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
		








func _on_texture_button_pressed():
	
	if k1 != false :
		InventoryMenu.hide();
		k1=false;
	else :
		InventoryMenu.show();
		JournalMenu.hide();
		CharacterMenu.hide();
		k1=true;
		k2=false
		k3=false




func _on_texture_button_2_pressed():
	if k2 != false :
		JournalMenu.hide();
		k2=false;
	else :
		InventoryMenu.hide();
		JournalMenu.show();
		CharacterMenu.hide();
		k1=false;
		k2=true
		k3=false


func _on_texture_button_3_pressed():
	if k3 != false :
		CharacterMenu.hide();
		k3=false;
	else :
		InventoryMenu.hide();
		JournalMenu.hide();
		CharacterMenu.show();
		k1=false;
		k2=false
		k3=true

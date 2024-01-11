extends Node

# ALl global variables should be here. You can access it by Global.varName 
var chosenResolution = 3
var chosenMode = 2
var shadow = 1;
#Player variables - nonscalabe should not be modified by equipment
var currentHp=10.0; #nonscalable
var maxHp=90.0;
var regenPerSec= 0;
var increasedLifeRecovery = 1.0;
var regenPool=0.0; #nonscalable
var currentStamina=60.0; #nonscalable
var maxStamina=60.0;
var staminaRegenPerSec = 0.3;
var increasedStaminaRecoveryRate=1.0;
var reducedFlatDmg=0.0;
var fireResistance=0.0;
var lightningResistance=0.0;
var coldResistance=0.0;
var physicalResistance=0.0;
var MinDmgPerAttack=2 
var MaxDmgPerAttack=2
var Strength = 6 # player gain +1 to min and +2 to max attack dmg per attack per 2 strength
var Agility = 6 # player gain increased movement speed and stamina regeneration rate per agility
var Endurance = 6 # player gain increased life, life regeneration and stamina regeneration per endurance 
#Variables for sign positions
#var NotWest = Main_map.get_tree().get_node("WestSign")
var West = Vector3(-493.53,119.589,-426.156)
var East = Vector3(-656.123,93.263,261.566)
var North = Vector3(553.014,76.344,441.588)
#Variables for GUI
var isMouseCaptured = false
var isGameScreenClear = true # it means there are no other window on screen that game and GUI
var isDialogOpen = false
#Variables to proceed story
var hoodedNpcTakenMissions=0
var targetForMonsters
var EQoppened = false
var isPlayerReady=false
#Log for every action
var log = "Welcome to Rdest world. You can move with WASD. Use control to show mouse. "
func addToLog(text):
	log+="\n"+text
func resetGame():
	log = "Welcome to Rdest world. You can move with WASD. Click ctrl to show mouse. "
	currentHp=10.0
	maxHp=90.0
	hoodedNpcTakenMissions=0
func dealDmgToPlayer(Physical,Fire,Lightning,Cold,True):
	var physicalDmg=Physical*(1-physicalResistance/100)-reducedFlatDmg
	var fireDmg=Fire*(1-fireResistance/100)-reducedFlatDmg
	var lightningDmg=Lightning*(1-lightningResistance/100)-reducedFlatDmg
	var coldDmg=Cold*(1-coldResistance/100)-reducedFlatDmg
	var trueDmg=True-reducedFlatDmg
	var sumDmg = physicalDmg+fireDmg+lightningDmg+coldDmg+trueDmg
	currentHp-=physicalDmg
	currentHp-=fireDmg
	currentHp-=lightningDmg
	currentHp-=coldDmg
	currentHp-=trueDmg
	var logMessage="\nYou were hit for "+str(sumDmg)+" hp. Damage taken (physical,fire,lightning,cold,true): ("+str(physicalDmg)+","+str(fireDmg)+","+str(lightningDmg)+","+str(coldDmg)+","+str(trueDmg)+")"
	addToLog(logMessage)
	if currentHp <= 0 :
		Die()
func Die():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	isMouseCaptured=false
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")

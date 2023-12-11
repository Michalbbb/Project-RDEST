extends Node


# ALl global variables should be here. You can access it by Global.varName 
var chosenResolution = 3
var chosenMode = 2
var shadow = 0;
var currentHp=50;
var maxHp=100;
var regenPerSec= 0.5;
var increasedLifeRecovery = 1.0;
var regenPool=0.0;
var currentStamina=100.0;
var maxStamina=100.0;
var staminaRegenPerSec = 1.5;
var increasedStaminaRecoveryRate=1.0;

#Variables for sign positions
#var NotWest = Main_map.get_tree().get_node("WestSign")
var West = Vector3(-493.53,119.589,-426.156)
var East = Vector3(-656.123,93.263,261.566)
var North = Vector3(553.014,76.344,441.588)



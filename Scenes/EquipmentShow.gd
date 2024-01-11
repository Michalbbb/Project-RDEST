extends TextureRect

var types=[load("res://Inventory/Items/Rune1.png"),load("res://Inventory/Items/Rune2.png"),load("res://Inventory/Items/Rune3.png")
,load("res://Inventory/Items/Rune4.png")]
var runes = []
var changesInRunes=false
var currentBloodRune 
var currentHolyRune
var currentMagicRune
var currentIronRune
@onready var container = $RuneHolder
@onready var BloodSlot =$BloodRuneSlot
@onready var HolySlot =$HolyRuneSlot
@onready var MagicSlot =$MagicRuneSlot
@onready var IronSlot =$IronRuneSlot
# Called when the node enters the scene tree for the first time.
func _ready():
	setUpSlots()
	addRunes()
	showRunes()
func setUpSlots():
	var runeStats=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
	var runeName="NAN"
	var runeType=0
	currentBloodRune=Rune.new(runeType,runeName,runeStats)
	currentHolyRune=Rune.new(runeType,runeName,runeStats)
	currentMagicRune=Rune.new(runeType,runeName,runeStats)
	currentIronRune=Rune.new(runeType,runeName,runeStats)
func addRunes():
	var runeStats=[20,0.0,0.0,0.0,0.0,0.0,0.0,50,0.0,0.0,0.0,0.0,0.0,0.0,4]
	var runeName="Blessed Holy Rune of Endurance"
	var runeType=2
	var newRune=Rune.new(runeType,runeName,runeStats)
	runes.append(newRune)
func showRunes():
	for i in container.get_children():
		i.queue_free()
	var counting = 0
	for i in runes:
		var textButton=TextureButton.new()
		textButton.tooltip_text=i.description()
		var type=i.getType()
		if type == 1: 
			textButton.texture_normal=types[0]
			textButton.connect("pressed",changeBloodRune.bind(textButton,counting))
		if type == 2: 
			textButton.texture_normal=types[1]
			textButton.connect("pressed",changeHolyRune.bind(textButton,counting))
		if type == 3: 
			textButton.texture_normal=types[2]
			textButton.connect("pressed",changeMagicRune.bind(textButton,counting))
		if type == 4: 
			textButton.texture_normal=types[3]
			textButton.connect("pressed",changeIronRune.bind(textButton,counting))
		container.add_child(textButton)
		counting+=1
func changeBloodRune(newButton,index):
	BloodSlot.texture_normal=newButton.texture_normal
	BloodSlot.tooltip_text=newButton.tooltip_text
	updateHolyRune(runes[index])
func changeHolyRune(newButton,index):
	HolySlot.texture_normal=newButton.texture_normal
	HolySlot.tooltip_text=newButton.tooltip_text
	updateHolyRune(runes[index])
func changeMagicRune(newButton,index):
	MagicSlot.texture_normal=newButton.texture_normal
	MagicSlot.tooltip_text=newButton.tooltip_text
	updateHolyRune(runes[index])
func changeIronRune(newButton,index):
	IronSlot.texture_normal=newButton.texture_normal
	IronSlot.tooltip_text=newButton.tooltip_text
	updateHolyRune(runes[index])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func updateHolyRune(rune):
	var stats=currentHolyRune.getStats()
	Global.maxHp-=stats[0]
	Global.regenPerSec-=stats[1]
	Global.increasedLifeRecovery-=stats[2]
	Global.maxStamina-=stats[3]
	Global.staminaRegenPerSec -=stats[4]
	Global.increasedStaminaRecoveryRate-=stats[5]
	Global.reducedFlatDmg-=stats[6]
	Global.fireResistance-=stats[7]
	Global.lightningResistance-=stats[8]
	Global.coldResistance-=stats[9]
	Global.physicalResistance-=stats[10]
	Global.MinDmgPerAttack -=stats[11]
	Global.MaxDmgPerAttack-=stats[11]
	Global.Strength -=stats[12]
	Global.Agility -=stats[13]
	Global.Endurance -=stats[14]
	currentHolyRune=rune
	stats=rune.getStats()
	Global.maxHp+=stats[0]
	Global.regenPerSec+=stats[1]
	Global.increasedLifeRecovery+=stats[2]
	Global.maxStamina+=stats[3]
	Global.staminaRegenPerSec +=stats[4]
	Global.increasedStaminaRecoveryRate+=stats[5]
	Global.reducedFlatDmg+=stats[6]
	Global.fireResistance+=stats[7]
	Global.lightningResistance+=stats[8]
	Global.coldResistance+=stats[9]
	Global.physicalResistance+=stats[10]
	Global.MinDmgPerAttack +=stats[11]
	Global.MaxDmgPerAttack+=stats[11]
	Global.Strength +=stats[12]
	Global.Agility +=stats[13]
	Global.Endurance +=stats[14]
func _process(delta):
	pass


class Rune:
	var type=1
	var name=""
	var stats=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
	var statsDescription=["Increases your max hp by ","Increases your life regeneration per second by ",
	"Your life recovers faster by ","Increases your max stamina by ","Increases your stamina regeneration per second by",
	"Your stamina recovers faster by ","Dmg you take is decreased by ","Your fire resistance is increased by ","Your lightning resistance is increased by ",
	"Your cold resistance is increased by ","Your physical resistance is increased by ","Increases damage per attack by ",
	"Increases strength by ","Increases agility by ","Increases endurance by "]
	var DescSuffix=["","","%","","","%","","%","%","%","%","","","",""]
	func _init(new_type=4,new_name="Iron rune of dragon",new_stats=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]):
		type=new_type
		name=new_name
		stats=new_stats
	func description():
		var desc = ""
		desc+=name+"\n"
		for i in 15:
			if stats[i] != 0.0: desc+=statsDescription[i]+str(stats[i])+DescSuffix[i]+"\n"
		return desc
	func getType():
		return type
	func getStats():
		return stats

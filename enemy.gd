extends KinematicBody


onready var hpsprite = $"Sprite3D"
onready var hpviewport = $"Sprite3D/Viewport"
onready var hpprogress = $"Sprite3D/Viewport/ProgressBar"

var hp = 100
var normalcolor = [255,38,175]
var damagedcolor = [255,0,0]
onready var damagetakencolortimer = $damagetakencolortimer
var damagetakencolortimerwaittime = 0.278
#onready var color = $"MeshInstance".material_override.albedo_color



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	hpsprite.set_texture(hpviewport.get_texture())


# Called every frame. 'delta' is the elapsed time since the previous frame.
"""
func _process(delta):
	#color
	normalcolor[0] - 
	var fractionoftimer = 1 - (damagetakencolortimer.get_time_left() / damagetakencolortimerwaittime) as float
	color = color.color8(normalcolor[0] - )
"""

func _on_Area_body_entered(body):
	if body.is_in_group("damaging"):
		hpprogress.value -= body._damage
		print("ive been hit! my hitpoints value is now ",hpprogress.value)
		body.queue_free()
		
#	damagetakencolortimer.start
	
	
	pass # Replace with function body.

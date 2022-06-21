extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var normalcolor = [255,38,175]
var damagedcolor = [255,0,0]
onready var damagetakencolortimer = $damagetakencolortimer
var damagetakencolortimerwaittime = 0.278
#onready var color = $"MeshInstance".material_override.albedo_color



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
"""
func _process(delta):
	#color
	normalcolor[0] - 
	var fractionoftimer = 1 - (damagetakencolortimer.get_time_left() / damagetakencolortimerwaittime) as float
	color = color.color8(normalcolor[0] - )
"""

func _on_Area_body_entered(body):
	print("ive been hit")
	body.queue_free()
#	damagetakencolortimer.start
	
	
	pass # Replace with function body.

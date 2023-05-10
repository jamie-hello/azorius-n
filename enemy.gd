#every enemy needs a sprite3d, viewport,progressbar, and then also a area+collision shape that sends a signal bodyentered
extends KinematicBody


"""onready var hpsprite = $"Sprite3D"
onready var hpviewport = $"Sprite3D/Viewport"
onready var hpprogress = $"Sprite3D/Viewport/ProgressBar"
onready var areafordamage = $"Area" """
onready var hpsprite
onready var hpviewport
onready var hpprogress 
onready var areafordamage

var hp = 100
var normalcolor = [255,38,175]
var damagedcolor = [255,0,0]
onready var initialized = false
onready var damagetakencolortimer = $damagetakencolortimer
var damagetakencolortimerwaittime = 0.278
#onready var color = $"MeshInstance".material_override.albedo_color



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func initialize(hp):
	initialized = true
	hpsprite = Sprite3D.new()
	hpsprite.set_billboard_mode(1)
	hpsprite.set_transform(Transform(Vector3(15, 0, 0), Vector3( 0, 15, 0), Vector3( 0, 0, 15), Vector3(0, 23.794399, 0)))
	hpsprite.transparent = true
	hpsprite.double_sided = true
	add_child(hpsprite)
	hpviewport = Viewport.new()
	hpviewport.set_size(Vector2(458,14))
	hpviewport.render_target_v_flip = true
	hpviewport.transparent_bg = true
	hpviewport.set_usage(0)
	hpsprite.add_child(hpviewport)
	hpprogress = ProgressBar.new()
	hpprogress.percent_visible = false
	var theme = preload("res://hpbar.tres")
	hpprogress.set_theme(theme)
	hpprogress.max_value = hp
	hpprogress.value = hp
	hpprogress._set_size(Vector2(458,14))
	hpviewport.add_child(hpprogress)
	areafordamage = Area.new()
	var collisionshape = CollisionShape.new()
	
	
	
func _process(delta):
	if initialized:
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

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
onready var boss = false
var speed = 6
var targetplayertranslation = Vector3.UP
var _velocity = Vector3.ZERO
var updateplayerposition = false
#onready var color = $"MeshInstance".material_override.albedo_color


func _ready():
	pass
	
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
	updateplayerposition = true
	
	
	
func _process(delta):
	if initialized:
		hpsprite.set_texture(hpviewport.get_texture())
signal sendmeplayerposition
func _physics_process(delta):
	if !boss:
		_velocity = -(self.translation - targetplayertranslation)
		_velocity = _velocity.normalized() * speed
		_velocity.y = -10
		move_and_slide(_velocity,Vector3.UP)
		if updateplayerposition:
			emit_signal("sendmeplayerposition")
			#self.look_at(targetplayertranslation,Vector3.UP)

func _on_Player_sendmyposition(translation):
	targetplayertranslation = translation
	

signal wiggle
func wiggle(dmg):
	emit_signal("wiggle",dmg)
	pass

func _on_Area_body_entered(body):
	if body.is_in_group("damaging"):
		hpprogress.value -= body._damage
		print("ive been hit! my hitpoints value is now ",hpprogress.value)
		wiggle(body._damage)
		body.queue_free()
		if hpprogress.value <= 0:
			queue_free()
		
#	damagetakencolortimer.start
	
	

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cooldown = $cooldown
onready var icon = $frozenorbicon
onready var textureprogress = $TextureProgress
var howlongisthecooldown = 2.5 #if u change this make sure to change it in the charged bolt script too




# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _process(_delta):
	
	
	if !cooldown.is_stopped():
		textureprogress.value = float(cooldown.get_time_left()/howlongisthecooldown * 100)

func _on_cooldown_timeout():
	textureprogress.value = 0

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cooldown = $cooldown
onready var icon = $Sprite
onready var textureprogress = $TextureProgress
var howlongisthecooldown = 2.7 #if u change this make sure to change it in the vortex script too and also -.2 active frames timer







func _process(_delta):
	
	
	if !cooldown.is_stopped():
		textureprogress.value = float(cooldown.get_time_left()/howlongisthecooldown * 100)

func _on_cooldown_timeout():
	textureprogress.value = 0

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ready():
	$ready.visible = true
	$go.visible = false
	$youwin.visible = false
	$youlose.visible = false
func go():
	$ready.visible=false
	$go.visible=true
	$youwin.visible = false
	$youlose.visible = false
	$Timer.start(0.25)
func youwin():
	$youwin.visible = true
	$youlose.visible = false


func _on_Timer_timeout():
	$ready.visible = false
	$go.visible = false
	$youwin.visible = false
	$Timer.queue_free()
	
func youlose():
	$ready.visible = false
	$go.visible = false
	$youwin.visible = false
	$youlose.visible = true

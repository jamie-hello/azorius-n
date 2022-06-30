extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var instance = preload("res://frozenorb instance.tscn")
onready var cooldowntimer = $"Control/cooldown"
onready var pretimer = $pretimer
onready var pushbacktimer = $pushbacktimer
var on_cooldown = false
var cooldowntime = 2.5 #if u change this make sure to change it in the control script too
var angle = Vector3.ZERO
signal preparepushback
signal pushbacking(angle)
signal endpushback


var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spell_use():
	if !on_cooldown:
		
		#broiler plate code for getting where we're looking with the mouse cursor to Vector3 angle
		var mousePos=get_viewport().get_mouse_position()
		var springarmdestx : float = ((mousePos[0] / get_viewport().size.x) - 0.5)
		var springarmdesty : float = -((mousePos[1] / get_viewport().size.y) - 0.5)
		angle = Vector3(-springarmdestx,0, springarmdesty)
		
		
		
		on_cooldown = true
		cooldowntimer.start(cooldowntime)
		pretimer.start()
		emit_signal("preparepushback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_cooldown_timeout():
	on_cooldown = false


func _on_pretimer_timeout():
	pushbacktimer.start()
	emit_signal("pushbacking",-angle)
	var newcast = instance.instance()
	newcast.initialize(damage,angle)
	newcast.transform = self.get_global_transform()
	get_tree().get_root().add_child(newcast)


func _on_pushbacktimer_timeout():
	emit_signal("endpushback")

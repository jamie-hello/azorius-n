extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var instance = preload("res://charged bolt instance.tscn")
onready var timer = $"dash timer"
onready var cooldowntimer = $"Control/cooldown"

var damage = 10
var angle2d = Vector2.ZERO
var instanceangle = 0
var boltstoshoot = 5
var on_cooldown = false
var cooldowntime = 2 #if u change this make sure to change it in the control script too
signal preparedashing
signal dashing(angle)
signal enddashing

func angle2d_to_vector3(ang) -> Vector3:
	return Vector3(-cos(ang),0,sin(ang))
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spell_use():
	if !on_cooldown:
		#edited broiler plate code for getting where we're looking with the mouse cursor to Vector3 angle
		#look at default spell for original
		var mousePos=get_viewport().get_mouse_position()
		var springarmdestx : float = ((mousePos[0] / get_viewport().size.x) - 0.5)
		var springarmdesty : float = -((mousePos[1] / get_viewport().size.y) - 0.5)
		angle2d = Vector2(springarmdestx,springarmdesty).angle()
		
		
		timer.pretimer.start()
		emit_signal("preparedashing")
		on_cooldown = true
		cooldowntimer.start(cooldowntime)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_dash_timer_timeout():
	var newcast
	for n in boltstoshoot: #default is 5, probably doesnt work for 6 or more correctly yet because of hardcoded radians but idk
		newcast = instance.instance()
		instanceangle = angle2d + (.174533 * n) - (2.5*.174533)
		newcast.initialize(damage,angle2d_to_vector3(instanceangle))
		newcast.transform = self.get_global_transform()
		get_tree().get_root().add_child(newcast)
	emit_signal("enddashing")


func _on_pretimer_timeout():
	emit_signal("dashing",angle2d_to_vector3(angle2d))


func _on_cooldown_timeout():
	on_cooldown = false
	pass # Replace with function body.

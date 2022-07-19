extends Spatial

onready var instance = preload("res://vortex instance.tscn")
onready var placer = $"vortex instance" #when fixing placer, u can just enable visability to see wher eit plops down at
onready var cooldowntimer = $"Control/cooldown"
var on_cooldown = false
var cooldowntime = 2.7 #if u change this make sure to change it in the control script too
var angle = Vector3.ZERO
signal vortexpretimer
signal vortexinputoverride(rotation_axis_at_center_of_vortex)
signal vortexendinputoverride
var angle2d = 0
var can_exit_whirlpool = false
var flipped = 0


var damage = 10



func _ready():
	placer.set_collision_mask(0)
	$"vortex instance/deletion timer".stop()
	$"vortex instance/ploptimer".stop()

func spell_use():
	if !on_cooldown:
		#roll for left or right
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		flipped = (rng.randi_range(0,1) * 2)-1
		
		
		#broiler plate code for getting where we're looking with the mouse cursor to Vector3 angle
		var mousePos=get_viewport().get_mouse_position()
		var springarmdestx : float = ((mousePos[0] / get_viewport().size.x) - 0.5)
		var springarmdesty : float = -((mousePos[1] / get_viewport().size.y) - 0.5)
		angle = Vector3(-springarmdestx,0, springarmdesty).normalized()
		angle2d = Vector2(-springarmdestx,springarmdesty).normalized().angle()
		placer.set_transform(placer.get_transform().rotated(Vector3.UP,angle2d))
		
		var newcast = instance.instance()
		newcast.initialize(damage,angle,flipped)
		newcast.connect("plopped",self,"_on_vortex_instance_plopped")

		
		newcast.transform = placer.get_global_transform()
		get_tree().get_root().add_child(newcast)
		
		on_cooldown = true
		cooldowntimer.start(cooldowntime)
		emit_signal("vortexpretimer")
	
	else:
		if can_exit_whirlpool:
			emit_signal("vortexendinputoverride")
			can_exit_whirlpool = false
		
		
		




func _on_vortex_instance_plopped():
	print("plopped in holder")
	var rotation_axis_at_center_of_vortex = placer.get_global_transform().origin
	emit_signal("vortexinputoverride",rotation_axis_at_center_of_vortex,flipped)
	placer.set_transform(placer.get_transform().rotated(Vector3.UP,-angle2d))
	can_exit_whirlpool = true

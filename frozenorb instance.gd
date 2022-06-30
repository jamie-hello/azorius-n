extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var instance = preload("res://frozen orb shard instance.tscn")
onready var placer = $"frozen orb shard instance"

var _damage = 1
var _angle = Vector3.ZERO
var speed = 5
var thirtysixdegrees = 0.628319
var rotationaccumulated = Vector3.FORWARD

func initialize(damage : int, angle : Vector3):
	_damage = damage
	_angle = angle.normalized() * speed
	$"frozen orb shard instance/deletion timer".stop() #dont delete the placeholder instance
	$"frozen orb shard instance".set_collision_mask(0)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_slide(_angle,Vector3.UP)
#	pass




func _on_deletion_timer_timeout():
	thirtysixdegrees = PI/7
	for n in 14:
		_on_new_shard_timer_timeout()
	queue_free()
	pass # Replace with function body.


func _on_new_shard_timer_timeout():
	var newangle = get_rotation()
	#set_rotation(get_global_transform().rotated(Vector3.UP,thirtysixdegrees))
	newangle.y += thirtysixdegrees
	set_rotation(newangle)
	rotationaccumulated = rotationaccumulated.rotated(Vector3.UP,thirtysixdegrees)
	var newcast = instance.instance()
	newcast.initialize(_damage,rotationaccumulated)
	newcast.transform = placer.get_global_transform()
	
	get_tree().get_root().add_child(newcast)
	pass # Replace with function body.

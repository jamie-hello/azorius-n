extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _damage = 1
var _angle = Vector3.ZERO
var speed = 18

func initialize(damage : int, angle : Vector3):
	_damage = damage
	_angle = angle.normalized() * speed
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_slide(_angle,Vector3.UP)
#	pass




func _on_deletion_timer_timeout():
	queue_free()
	pass # Replace with function body.

extends KinematicBody


"""
bolt instance scene
	bolt graphic
	bolt hitbox
	bolt damage
	angle
	angle true (random amount + angle)
	timer of 15 seconds for timeout
	timer to change angle, then resets to some random timer interval between 0.4 and .8
"""

var _damage = 1
var _angle = Vector3.ZERO
var speed = 13
var anglebias = 0
const eightydegrees = 1.39626

func initialize(damage : int, angle : Vector3):
	_damage = damage
	_angle = angle.normalized() * speed 
	anglebias = Vector2(_angle.x,_angle.z).angle()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_slide(_angle,Vector3.UP)
#	pass





func _on_change_angle_timer_timeout():
	#change the angle to a random angle within 80 degrees
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var newangle = anglebias + rng.randf_range(-eightydegrees/2,eightydegrees/2)
	_angle = Vector3(cos(newangle),0,sin(newangle)).normalized() * speed
	pass


func _on_deletion_timeout_timeout():
	queue_free()

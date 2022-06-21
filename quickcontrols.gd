extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta) -> void:
	_velocity.x = (Input.get_action_strength("left") - Input.get_action_raw_strength("right")) * 10
	_velocity.z = (Input.get_action_strength("up") - Input.get_action_raw_strength("down")) * 10
	_velocity.y = -10
	move_and_slide(_velocity, Vector3.UP,false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

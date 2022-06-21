extends KinematicBody
#hello

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 600
var _velocity = Vector3.ZERO
var cameraheight = 30
var input_interrupted = false #if a monster pushed you back or if you are dashing
onready var cameraArms_xz : SpringArm = $"CameraArms/SpringArm leftright"
onready var cameraArms_y = $"CameraArms/SpringArm leftright/SpringArm updown"
onready var camera = $"CameraArms/SpringArm leftright/SpringArm updown/Camera"
onready var spell = $"charged bolt"
onready var spell2 = $"default spell"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta) -> void:
	_velocity.y = 0
	if !input_interrupted:
		_velocity.x = (Input.get_action_strength("left") - Input.get_action_raw_strength("right")) 
		_velocity.z = (Input.get_action_strength("up") - Input.get_action_raw_strength("down")) 
	_velocity = _velocity.normalized() * speed * _delta
	_velocity.y = -800 * _delta
	move_and_slide(_velocity, Vector3.UP,false)
	
	"""
	#i need to control the camera arms every process frame
	#i need to get cursor position details
	var mousePos=get_viewport().get_mouse_position()
	#i need to use those details to move xz springarm and ignore collision somehow
	#print("mousePos ",mousePos[0],", ",mousePos[1],". size of window is ",get_viewport().size.x,", ",get_viewport().size.y)
	var springarmdestx : float = (mousePos[0] / get_viewport().size.x) - 0.5
	var springarmdesty : float = (mousePos[1] / get_viewport().size.y) - 0.5
	#print("springarmdest is ",springarmdestx,", ",springarmdesty)
	var springarmxz = Vector2(springarmdestx, springarmdesty)
	cameraArms_xz.set_rotation(Vector3(0,springarmxz.angle(),0))
	cameraArms_xz.set_length(springarmxz.length() * 50)
	#print("cameraArmxz length is ",springarmxz.length()," and angle is ",springarmxz.angle())
	
	cameraArms_y.set_length(cameraheight)
	#i need to set cameraArms to collision mask 2 or something to noclip into walls
	"""
	
func _input(event):
	if event.is_action_pressed("use spell"):
		spell.spell_use()
	elif event.is_action_pressed("use spell 2"):
		spell2.spell_use()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_charged_bolt_preparedashing():
	input_interrupted = true
	_velocity = Vector3.ZERO
func _on_charged_bolt_dashing(angle):
	input_interrupted = true
	_velocity = angle
	speed = 4000
func _on_charged_bolt_enddashing():
	_velocity = Vector3.ZERO
	input_interrupted = false
	speed = 600
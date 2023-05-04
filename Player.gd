extends KinematicBody
#hello

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 10
var basespeed = 10
var _velocity = Vector3.ZERO
var cameraheight = 30
var input_interrupted = false #if a monster pushed you back or if you are dashing
onready var vortexpivot = preload("res://vortexpivot.tscn")
onready var cameraArms_xz : SpringArm = $"CameraArms/SpringArm leftright"
onready var cameraArms_y = $"CameraArms/SpringArm leftright/SpringArm updown"
onready var camera = $"CameraArms/SpringArm leftright/SpringArm updown/Camera"
onready var spell = $"charged bolt"
#onready var spell2 = $"default spell"
onready var spell2 = $"frozenorb"
#onready var spell3 = $"vortex"
onready var fps_label = $fps_label


# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.time_scale = 1
	pass

func _process(delta) -> void:
	
	
	fps_label.set_text(str(Engine.get_frames_per_second() , " " , str(OS.get_ticks_msec()) , " " , str(delta), " ", 
	str(self.get_transform())))
	
	_velocity.y = 0
	if !input_interrupted:
		_velocity.x = (Input.get_action_strength("left") - Input.get_action_raw_strength("right")) 
		_velocity.z = (Input.get_action_strength("up") - Input.get_action_raw_strength("down")) 
	_velocity = _velocity.normalized() * speed
	_velocity.y = -14
	#move_and_slide(_velocity, Vector3.UP,true)
	#move_and_slide_with_snap(_velocity,Vector3.DOWN,Vector3.UP,true)
	
func _physics_process(delta):
	move_and_slide_with_snap(_velocity,Vector3.DOWN,Vector3.UP,true)
	
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
	if !input_interrupted:
		if event.is_action_pressed("use spell"):
			spell.spell_use()
		elif event.is_action_pressed("use spell 2"):
			spell2.spell_use()
		elif event.is_action_pressed("use spell 3"):
			#spell3.spell_use()
			pass
		elif event.is_action_pressed("ui_cancel"):
			get_tree().quit()
	





#charged bolt
func _on_charged_bolt_preparedashing():
	input_interrupted = true
	_velocity = Vector3.ZERO
func _on_charged_bolt_dashing(angle):
	input_interrupted = true
	_velocity = angle
	speed = 67
func _on_charged_bolt_enddashing():
	_velocity = Vector3.ZERO
	input_interrupted = false
	speed = basespeed


#frozen orb
func _on_frozenorb_preparepushback():
	input_interrupted = true
	_velocity = Vector3.ZERO
func _on_frozenorb_pushbacking(angle):
	input_interrupted = true
	_velocity = angle
	speed = 21
func _on_frozenorb_endpushback():
	_velocity = Vector3.ZERO
	input_interrupted = false
	speed = basespeed


#vortex
var vortexpivotinstance
var vortexcollisionshape
var vortexpivotcameraarms
var vortexpivottowermodel
func _on_vortex_vortexpretimer(): #stop input and stay still and play the animation
	input_interrupted = true
	_velocity = Vector3.ZERO
func _on_vortex_vortexinputoverride(rotation_axis_at_center_of_vortex,direction):
	#i think i need to assign colliosion cameraarms towermodel to a dummy node
	#then rotate the dummy node
	#then on vortexendinputoverride i will update the real position and remove the dummy node
	vortexpivotinstance = vortexpivot.instance()
	vortexpivotinstance.set_translation(rotation_axis_at_center_of_vortex)
	vortexcollisionshape = $"CollisionShape"
	#vortexpivotcameraarms = $"CameraArms"
	vortexpivottowermodel = $"towermodel"
	remove_child(vortexcollisionshape)
	#remove_child(vortexpivotcameraarms)
	remove_child(vortexpivottowermodel)
	vortexpivotinstance.add_child(vortexcollisionshape)
	#vortexpivotinstance.add_child(vortexpivotcameraarms)
	vortexpivotinstance.add_child(vortexpivottowermodel)
	vortexpivotinstance.set_direction(direction)
	print(str(vortexcollisionshape))
	#the dummy node vortexpivot has a script that automatically rotates
func _on_vortex_vortexendinputoverride():
	vortexpivotinstance.remove_child(vortexcollisionshape)
	#vortexpivotinstance.remove_child(vortexpivotcameraarms)
	vortexpivotinstance.remove_child(vortexpivottowermodel)
	add_child(vortexcollisionshape)
	#add_child(vortexpivotcameraarms)
	add_child(vortexpivottowermodel)
	vortexpivotinstance.queue_free()
	input_interrupted = false
	_velocity = Vector3.ZERO


signal sendmyposition
func _on_ChainChomp_sendmeplayerposition():
	#for chainchomp looking and dashing toward the player
	emit_signal("sendmyposition",self.get_translation())
	pass # Replace with function body.

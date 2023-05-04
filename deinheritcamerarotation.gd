extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var xz = $"SpringArm leftright"
onready var y = $"SpringArm leftright/SpringArm updown"
onready var camera = $"SpringArm leftright/SpringArm updown/Camera"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	#i need to control the camera arms every process frame
	#i need to get cursor position details
	var mousePos=get_viewport().get_mouse_position()
	#i need to use those details to move xz springarm and ignore collision somehow
	#print("mousePos ",mousePos[0],", ",mousePos[1],". size of window is ",get_viewport().size.x,", ",get_viewport().size.y)
	var springarmdestx : float = ((mousePos[0] / get_viewport().size.x) - 0.5)
	var springarmdesty : float = -((mousePos[1] / get_viewport().size.y) - 0.5)
	#print("springarmdest is ",springarmdestx,", ",springarmdesty)
	var springarmxz = Vector2(springarmdesty, springarmdestx)
	xz.set_rotation(Vector3(0,-springarmxz.angle(),0))
	xz.set_length(springarmxz.length() * 40)
	#print("cameraArmxz length is ",springarmxz.length()," and angle is ",springarmxz.angle())
	
	y.set_length(35)
	#i need to set cameraArms to collision mask 2 or something to noclip into walls
	
	
	
	y.set_rotation(-xz.get_rotation() + Vector3(-PI/2,0,PI/2))
	#print(xz.rotation," ",y.rotation," ",camera.rotation)
	camera.set_rotation(Vector3(0,0.01,PI/2))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

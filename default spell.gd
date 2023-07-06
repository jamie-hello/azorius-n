extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var instance = preload("res://default spell instance.tscn")


var damage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spell_use():
	var newcast = instance.instance()
	
	#broiler plate code for getting where we're looking with the mouse cursor to Vector3 angle
	var mousePos=get_viewport().get_mouse_position()
	var springarmdestx : float = ((mousePos[0] / get_viewport().size.x) - 0.5)
	var springarmdesty : float = -((mousePos[1] / get_viewport().size.y) - 0.5)
	var angle = Vector3(-springarmdestx,0, springarmdesty)
	newcast.initialize(damage,angle)
	newcast.transform = self.get_global_transform()
	
	get_tree().get_root().add_child(newcast)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

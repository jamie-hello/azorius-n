extends Area


var _damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_mask = 0
	pass # Replace with function body.

func activate():
	collision_mask = 4
func deactivate():
	collision_mask = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Spatial
#over .8 seconds it should do one full rotation
var direction := 1
func _process(delta):
	set_transform(get_transform().rotated(Vector3.UP,2.5*PI*delta*direction))
func set_direction(value):
	direction = value

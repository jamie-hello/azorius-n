extends Area

var _damage = 1

func activate():
	collision_mask = 4
	pass
func deactivate():
	collision_mask = 0
	get_parent().queue_free()
	pass

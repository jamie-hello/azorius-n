extends Spatial
var hpvalue = 105
onready var instance = preload("res://the dude.tscn")

func spell_use():
	var newcast = instance.instance()
	newcast.transform = self.get_global_transform()
	get_tree().get_root().add_child(newcast)
	
	newcast.initialize(hpvalue)

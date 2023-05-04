extends Spatial

onready var instance = preload("res://boulderenemyspellinstance.tscn")
var firstwall
var secondwall
var thirdwall
var fourthwall
var howmanywalls


func _ready():
	pass # Replace with function body.


#func _process(delta):
#	pass

func wall(wall):
	var output = []
	match wall:
		1:
			output = [-31,26,0,-2,26]
		2:
			output = [-31,26,2,0,32]
		3:
			output = [31,26,0,-2,26]
		4:
			output = [-31,-26,2,0,32]
	return output
	
func spell_use():
	#phase1
	#pick a wall to set boulders a-tumblin' down
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	firstwall = rng.randi_range(1,4)
	rng.randomize()
	secondwall = rng.randi_range(1,4)
	rng.randomize()
	thirdwall = rng.randi_range(1,4)
	rng.randomize()
	fourthwall = rng.randi_range(1,4)
	firstwall = wall(firstwall)
	secondwall = wall(secondwall)
	thirdwall = wall(thirdwall)
	fourthwall = wall(fourthwall)
	rng.randomize()
	howmanywalls = rng.randi_range(2,4)
	$phaseone.start(3000)
	
func phasetwo():
	
	var newcast = instance.instance()
	
	
	
	newcast.transform.set_translation(31,1,26)
	get_tree().get_root().add_child(newcast)

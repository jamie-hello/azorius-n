extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_change_angle_timer_timeout():
	#random interval between 400 800 ms
	rng.randomize()
	start(rng.randf_range(.4,.8))
	pass # Replace with function body.

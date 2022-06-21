extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var waittime = .2
onready var pretimer = $"pretimer"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_wait_time(waittime)
	pretimer.set_wait_time(.1)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_pretimer_timeout():
	start(waittime)
	print("starting dash timer for ",waittime)
	


func _on_dash_timer_timeout():
	set_wait_time(waittime)

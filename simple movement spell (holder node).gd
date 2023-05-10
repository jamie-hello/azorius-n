extends Spatial

signal winding_up
signal waitingtodash
signal startdashing
signal donedashing
onready var windingtimer = $"winding up"
onready var donewindingtimer = $"done winding"
onready var dashtimer = $"length of dash"
onready var cooldown = $"total cooldown"
var cooldownready = true
var angle = 0

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass

func _on_winding_up_timeout():
	print("im done winding up! now im gonna launch any moment now!!")
	donewindingtimer.set_wait_time(.5)
	donewindingtimer.start()
	emit_signal("waitingtodash")

func _on_done_winding_timeout():
	print("launch!!")
	dashtimer.set_wait_time(.4)
	dashtimer.start()
	emit_signal("startdashing")

func _on_length_of_dash_timeout():
	print("i finished moving. i hope i hit u!!")
	emit_signal("donedashing")


func _on_total_cooldown_timeout():
	cooldownready = true
	
	
func spell_use():
		if cooldownready:
			cooldownready = false
			print("im gonna use my spell!!!! first i'll wind up! im looking at the player now!")
			cooldown.set_wait_time(2.2)
			cooldown.start()
			windingtimer.set_wait_time(1.2)
			windingtimer.start()
			emit_signal("winding_up")
			
		
		



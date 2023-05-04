extends Spatial


#i need spell holders just like player. i will begin with searing exarch bourlders
var spell1 = ""
var _velocity = Vector3.ZERO
var speed = 0
signal sendmeplayerposition

func _ready():
	pass 
	
func _physics_process(delta):
	if updateplayerposition:
		emit_signal("sendmeplayerposition")
		self.look_at(targetplayertranslation,Vector3.UP)
	
	
	
		
#here's the deal. enemy is like a player. 
#-player gets a signal from the spell it holds. player executes the spell effects
#-enemey needs to receive a signal from the spell it holds and execute the effects


	

var updateplayerposition = false
func _on_simple_movement_spell_holder_node_winding_up():
	#i need to get the angle to the player and look at them
	updateplayerposition = true
	pass # Replace with function body.


func _on_simple_movement_spell_holder_node_startdashing():
	#dash fast toward the player, and hit the player too
	speed = 50
	pass # Replace with function body.


func _on_simple_movement_spell_holder_node_donedashing():
	#stop moving
	speed = 0
	pass # Replace with function body.

var targetplayertranslation = Vector3.ZERO
func _on_Player_sendmyposition(translation):
	targetplayertranslation = translation


func _on_simple_movement_spell_holder_node_waitingtodash():
	updateplayerposition = false

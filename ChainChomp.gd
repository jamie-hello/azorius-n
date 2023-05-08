extends KinematicBody


#i need spell holders just like player. i will begin with searing exarch bourlders
var spell1 = ""
var _velocity = Vector3.ZERO
var speed = 0
var hp = 5000
onready var enemyscriptstuff = $"KinematicBody"
onready var hpprogress = $"KinematicBody/Sprite3D/Viewport/ProgressBar"
signal sendmeplayerposition

func _ready():
	hpprogress.max_value = hp
	hpprogress.value = hp
	pass 
	
func _physics_process(delta):
	if updateplayerposition:
		emit_signal("sendmeplayerposition")
		self.look_at(targetplayertranslation,Vector3.UP)
	_velocity = charge_targetposition * speed
	move_and_slide(_velocity,Vector3.UP)
	
	
	
	
		
#here's the deal. enemy is like a player. 
#-player gets a signal from the spell it holds. player executes the spell effects
#-enemey needs to receive a signal from the spell it holds and execute the effects


	

var updateplayerposition = false
func _on_simple_movement_spell_holder_node_winding_up():
	#i need to get the angle to the player and look at them
	updateplayerposition = true


func _on_simple_movement_spell_holder_node_startdashing():
	#dash fast toward the player, and hit the player too
	speed = 70


func _on_simple_movement_spell_holder_node_donedashing():
	#stop moving
	speed = 0

var targetplayertranslation = Vector3.ZERO
var charge_targetposition = Vector3.ZERO
func _on_Player_sendmyposition(translation):
	targetplayertranslation = translation


func _on_simple_movement_spell_holder_node_waitingtodash():
	updateplayerposition = false
	charge_targetposition = -(self.translation - targetplayertranslation)
	charge_targetposition.y = 0
	charge_targetposition = charge_targetposition.normalized()
	print(charge_targetposition)

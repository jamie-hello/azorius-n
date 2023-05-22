extends KinematicBody


#i need spell holders just like player. i will begin with searing exarch bourlders
onready var spell1 = $"simple movement spell (holder node)"
onready var spell2 = $"make a dude spell"
onready var simplescripttimer = $"simple ai script timer"
var _velocity = Vector3.ZERO
var wigglebias = Vector3.ZERO
var speed = 0
var hp = 500
onready var enemyscriptstuff = $"KinematicBody"
#onready var hpprogress = $"KinematicBody/Sprite3D/Viewport/ProgressBar"
signal sendmeplayerposition

func _ready():
	#enemyscriptstuff.initialized = true
	enemyscriptstuff.initialize(hp)
	enemyscriptstuff.boss = true
	simplescripttimer.start(3.5)
	
func _physics_process(delta):
	if updateplayerposition:
		emit_signal("sendmeplayerposition")
		self.look_at(targetplayertranslation,Vector3.UP)
	_velocity = charge_targetposition * speed
	move_and_slide(_velocity,Vector3.UP)
	if wiggling:
		wigglebias = $"MeshInstance".get_translation() / -6
		$"MeshInstance".set_translation($"MeshInstance".get_translation()+
			Vector3(
				($"MeshInstance/wiggletimer".time_left * rand_range(-10,10))+wigglebias.x,
				($"MeshInstance/wiggletimer".time_left * rand_range(-10,10))+wigglebias.y,
				($"MeshInstance/wiggletimer".time_left * rand_range(-10,10))+wigglebias.z
			)
		)
	
	
	
	
		
#here's the deal. enemy is like a player. 
#-player gets a signal from the spell it holds. player executes the spell effects
#-enemey needs to receive a signal from the spell it holds and execute the effects


	
"""func _input(event):
	if event.is_action_pressed("use enemy spell1"):
		spell1.spell_use()
	if event.is_action_pressed("use enemy spell2"):
		spell2.spell_use()"""

var updateplayerposition = false
func _on_simple_movement_spell_holder_node_winding_up():
	#i need to get the angle to the player and look at them
	updateplayerposition = true


func _on_simple_movement_spell_holder_node_startdashing():
	#dash fast toward the player, and hit the player too
	speed = 70
	$"bite charge".activate()


func _on_simple_movement_spell_holder_node_donedashing():
	#stop moving
	speed = 0
	$"bite charge".deactivate()

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

var simpleaiscript_count = 0
func _on_simple_ai_script_timer_timeout():
	simpleaiscript_count +=1
	if simpleaiscript_count%2 == 0:
		spell1.spell_use()
		simplescripttimer.start(3.1)
	else:
		spell2.spell_use()
		simplescripttimer.start(2.1)
	
	
	

signal youwin
func _on_KinematicBody_tree_exited():
	simplescripttimer.stop()
	emit_signal("youwin")
	queue_free()

var wiggling = false
func _on_KinematicBody_wiggle():
	wiggling = true
	$"MeshInstance/wiggletimer".start(1)
func _on_wiggletimer_timeout():
	$"MeshInstance".set_translation(Vector3.ZERO)
	wigglebias = Vector3.ZERO
	wiggling = false

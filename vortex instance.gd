extends KinematicBody



var _damage = 1
var _angle = Vector3.ZERO
var speed = 0
onready var plopplayer = $plop
onready var ploptimer = $ploptimer
#onready var plopplayer2 = $plop2 #scale x -1
signal plopped


func initialize(damage : int, angle : Vector3, direction):
	_damage = damage
	_angle = angle.normalized() * speed
	$Particles.emitting = false
	$Particles2.emitting = false
	"""
	match direction:
		-1:
			plopplayer.playback_active(false)
		1:
			plopplayer2.playback_active(false)
	"""
	pass





func _process(_delta):
	pass




func _on_deletion_timer_timeout():
	queue_free()

func _on_damage_pulse_timeout():
	print("deal damage")
	pass








func _on_ploptimer_timeout():
	emit_signal("plopped")
	$Particles.emitting = true
	$Particles2.emitting = true
	$"damage pulse".start()
	print("plopped in instance")

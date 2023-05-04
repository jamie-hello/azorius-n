extends DirectionalLight

var accumulated_h

func _ready():
	accumulated_h = 0

"""func _process(delta):
	accumulated_h += delta
	accumulated_h = fmod(accumulated_h,10)
	self.set_shadow_color(Color.from_hsv(accumulated_h/6, 0.18, 0.40))
"""

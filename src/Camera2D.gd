extends Camera2D

var speed : float = 500.0

func _process(delta):
	translate(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed * delta / Engine.time_scale)

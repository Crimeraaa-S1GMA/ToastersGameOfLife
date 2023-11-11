extends Camera2D

var speed : float = 50.0

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		translate(Vector2.RIGHT * speed * delta)
	if Input.is_action_pressed("ui_left"):
		translate(Vector2.LEFT * speed * delta)
	if Input.is_action_pressed("ui_up"):
		translate(Vector2.UP * speed * delta)
	if Input.is_action_pressed("ui_down"):
		translate(Vector2.DOWN * speed * delta)

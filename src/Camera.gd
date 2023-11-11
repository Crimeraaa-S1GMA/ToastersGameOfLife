extends Camera

# Declare member variables here. Examples:
var sensitivity = 0.02
var speed = 100.0

func _process(delta):
	var direction = Vector3()
	
	if Input.is_action_pressed("ui_right"):
		direction += Vector3.RIGHT
	if Input.is_action_pressed("ui_left"):
		direction -= Vector3.RIGHT
	if Input.is_action_pressed("ui_up"):
		direction += Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		direction -= Vector3.FORWARD
	
	# Move the node based on the direction
	move_in_direction(direction.normalized(), delta)

func move_in_direction(direction, delta):
	# Get the current transform of the node
	var transform = get_transform()
	
	# Rotate the direction vector based on the node's rotation
	var rotated_direction = transform.basis.xform(direction)
	
	# Update the translation of the node based on the rotated direction
	translation += rotated_direction * speed * delta

func _input(event):
	if event is InputEventMouseMotion:
		# Process mouse input
		var rotation = event.speed
		rotation *= sensitivity
		rotation.y = clamp(rotation.y, -90, 90)  # Limit vertical rotation to avoid flipping

		rotate_object_local(Vector3(1, 0, 0), deg2rad(rotation.y))
		rotate_y(deg2rad(rotation.x))

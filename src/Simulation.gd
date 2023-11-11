extends Node2D

onready var particles : Node2D = $Particles

onready var particle : PackedScene = preload("res://src/Particle.tscn")

var brush_type : int = 0

func _ready():
	randomize()
	
	for i in range(SimulationManager.particle_types):
		for j in range(500 / SimulationManager.particle_types):
			var particle_ins = particle.instance()

			particle_ins.type = i

			particles.add_child(particle_ins)
			particle_ins.position = Vector2(rand_range(-100.0, 100.0), rand_range(-100.0, 100.0))
			if i % 100 == 0: yield(get_tree(), "idle_frame")
	
	SimulationManager.started = true

func _process(delta):
#	var particle_ins = particle.instance()
#	particle_ins.type = 1
#
#	particles.add_child(particle_ins)
	
	var pause : bool = false
	
	if Input.is_action_just_pressed("1"):
		brush_type = 0
	if Input.is_action_just_pressed("2"):
		brush_type = 1
	if Input.is_action_just_pressed("3"):
		brush_type = 2
	if Input.is_action_just_pressed("4"):
		brush_type = 3
	if Input.is_action_just_pressed("5"):
		brush_type = 4
	if Input.is_action_just_pressed("6"):
		brush_type = 5
	if Input.is_action_just_pressed("7"):
		brush_type = 6
	if Input.is_action_just_pressed("8"):
		brush_type = 7
	if Input.is_action_just_pressed("9"):
		brush_type = 8
	if Input.is_action_just_pressed("0"):
		brush_type = 9
	if Input.is_action_just_pressed("random"):
		brush_type = 10
	
	if Input.is_action_pressed("pause"):
		pause = true
	
	if Input.is_action_pressed("click"):
		pause = true
		var particle_ins_draw = particle.instance()
		
		particle_ins_draw.type = (randi() % SimulationManager.particle_types) if brush_type == 10 else brush_type
		
		particles.add_child(particle_ins_draw)
		particle_ins_draw.position = get_global_mouse_position()
	
	get_tree().paused = pause


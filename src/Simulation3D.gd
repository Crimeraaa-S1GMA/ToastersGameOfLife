extends Spatial

onready var particles : Spatial = $Particles

onready var particle : PackedScene = preload("res://src/Particle3D.tscn")

var brush_type : int = 0

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	randomize()
	
	for i in range(SimulationManager.particle_types):
		for j in range(1000 / SimulationManager.particle_types):
			var particle_ins = particle.instance()

			particle_ins.type = i

			particles.add_child(particle_ins)
			particle_ins.translation = Vector3(rand_range(-100.0, 100.0), rand_range(-100.0, 100.0), rand_range(-100.0, 100.0))
			if i % 100 == 0: yield(get_tree(), "idle_frame")
	
	SimulationManager.started = true


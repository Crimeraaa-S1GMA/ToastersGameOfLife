extends Area

class_name Particle3D

onready var mesh_instance : MeshInstance = $MeshInstance
onready var particle_finder : Area = $ParticleFinder

var velocity : Vector3
var type : int = 0

func _ready():
	mesh_instance.set_surface_material(0, SimulationManager.materials[type % SimulationManager.materials.size()])
	
	randomize()
	
	var rand_angle : float = rand_range(-180.0, 180.0)

func _process(delta):
#	if abs(translation.x) > 500 or abs(translation.y) > 500 or abs(translation.z) > 500:
#		velocity = velocity.linear_interpolate(translation.normalized() * -100, 0.5)
	
	if SimulationManager.started:
		translate(velocity * delta)
		
		for i in particle_finder.get_overlapping_areas():
			if i.get_parent() != self:
				velocity += get_force(i.translation, i.type)
		
		velocity *= 0.6

func get_force(to : Vector3, foreign_type : int) -> Vector3:
	var direction : Vector3 = (to - translation).normalized()
	
	var distance : float = translation.distance_to(to)
	
	var force : float = 0
	
	force += min(((distance * 1.5) - 25), 0)
	
	force += max((abs(distance - 30) * -1) + 17, 0) * SimulationManager.rules[type][foreign_type]
	
	return direction * force

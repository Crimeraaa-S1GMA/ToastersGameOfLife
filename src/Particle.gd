extends Area2D

class_name Particle

onready var particle_finder : Area2D = $ParticleFinder

var velocity : Vector2
var type : int = 0

func _ready():
	randomize()

func _process(delta):
#	if abs(position.x) > 500 or abs(position.y) > 500:
#		velocity = velocity.linear_interpolate(position.normalized() * -100, 0.5)
	
	if SimulationManager.started:
		modulate = SimulationManager.colors[type % SimulationManager.colors.size()]
		
		translate(velocity * delta)
		
		for i in particle_finder.get_overlapping_areas():
			if i.get_parent() != self:
				velocity += get_force(i.position, i.type)
		
		velocity *= SimulationManager.friction

func get_force(to : Vector2, foreign_type : int) -> Vector2:
	var direction : Vector2 = (to - position).normalized()
	
	var distance : float = position.distance_to(to)
	
	var force : float = 0
	
	if SimulationManager.repulse_close_particles:
		force += min((((distance * distance) * 1.5) - 10) * 3, 0)
	
	var attraction : float = max((abs(distance - (50 * SimulationManager.attraction_range)) * (-0.5 / SimulationManager.attraction_range)) + 15, 0) * SimulationManager.rules[type][foreign_type]
	
	force += attraction
	
	return direction * force

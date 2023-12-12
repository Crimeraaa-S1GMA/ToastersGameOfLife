using Godot;
using System;

public class Particle : Area2D
{
	public Vector2 velocity;
	public uint type;

	public override void _Ready()
	{
		GD.Randomize();

		Connect("area_entered", this, "Enter");
		Connect("area_exited", this, "Exit");
	}

	public override void _Process(float delta)
	{
		SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

		Modulate = simulationManager.colors[type % simulationManager.particleTypes];
		
		if(simulationManager.started) {
			if (Mathf.Abs(Position.x) > 500 || Mathf.Abs(Position.y) > 500) {
				velocity = velocity.LinearInterpolate(Position.Normalized() * -100, 0.5f);
			}

			Translate(velocity * delta);
		}

		foreach(Particle particle in simulationManager.particles) {
			if (particle != null) {
				if (particle != this) {
					velocity += GetForce(particle.Position, particle.type);
				}
			}
		}

		velocity *= simulationManager.friction;
	}

	Vector2 GetForce(Vector2 to, uint foreignType) {
		SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

		Vector2 direction = (to - Position).Normalized();

		float distance = Position.DistanceTo(to);

		float particleForce = 0;

		particleForce = Mathf.Min((distance - 20) * 3, 0);

		float attraction = Mathf.Max((Mathf.Abs(distance - 50) * -0.5f) + 15, 0) * Convert.ToSingle(simulationManager.rules[type, foreignType]);

		// // var attraction : float = max((abs(distance - 50) * -0.5) + 15, 0) * SimulationManager.rules[type][foreign_type]

		// float attraction = Mathf.Max((Mathf.Abs(distance - 50) * -0.5f) + 15, 0);

		particleForce += attraction;

		return direction * particleForce;
	}

	void Enter(Area2D area) {
	}

	void Exit(Area2D area) {
	}
}

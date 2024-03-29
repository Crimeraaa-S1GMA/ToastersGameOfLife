using Godot;
using Godot.Collections;
using System;

public class Particle : Node2D
{
	public Vector2 velocity;
	public uint type;

	public override void _Ready()
	{
		SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

		simulationManager.particles.Add(this);

		GD.Randomize();
	}

	public override void _Process(float delta)
	{
		SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

		Modulate = simulationManager.colors[type % simulationManager.particleTypes];
		
		if(simulationManager.started) {
			// if (Mathf.Abs(Position.x) > 500 || Mathf.Abs(Position.y) > 500) {
			// 	velocity = velocity.LinearInterpolate(Position.Normalized() * -100, 0.5f);
			// }

			Translate(velocity * delta);
			Translate(Vector2.Right * 20 * delta);
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

		float attraction = Mathf.Max((Mathf.Abs(distance - 50) * -0.5f) + 15, 0) * Convert.ToSingle(((Dictionary)simulationManager.rules[type])[foreignType]);

		particleForce += attraction;

		return direction * particleForce;
	}
}

using Godot;
using System;

public class Simulation : Node2D
{
    private Node2D particles;

    private PackedScene particle;

    private int brushType = 0;

    public override void _Ready()
    {
        SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

        particles = (Node2D)GetNode("Particles");
        particle = (PackedScene)GD.Load("res://src/Particle.tscn");

        GD.Randomize();

        simulationManager.particles.Clear();

        for(int i = 0; i < simulationManager.particleTypes; i++) {
            for(int j = 0; j < 100 / simulationManager.particleTypes; j++) {
                Particle particleInstance = (Particle)particle.Instance();

                particleInstance.type = Convert.ToUInt32(i);

                particles.AddChild(particleInstance);
                particleInstance.Position = new Vector2(Convert.ToSingle(GD.RandRange(-100.0, 100.0)), Convert.ToSingle(GD.RandRange(-100.0, 100.0)));

                simulationManager.particles.Add(particleInstance);
            }
        }

        simulationManager.started = true;
    }

    public override void _Process(float delta)
    {
        if(Input.IsActionPressed("click") && !GetTree().IsInputHandled()) {
            SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

            GetTree().SetInputAsHandled();

            Particle particleInstanceDraw = (Particle)particle.Instance();

            particleInstanceDraw.type = GD.Randi() % 10;

            particles.AddChild(particleInstanceDraw);
            particleInstanceDraw.Position = GetGlobalMousePosition();
        }
    }
}

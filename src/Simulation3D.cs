using Godot;
using System;

public class Simulation3D : Spatial
{
    private Spatial particles;

    private PackedScene particle;

    private int brushType = 0;

    public override void _Ready()
    {
        Input.MouseMode = Input.MouseModeEnum.Captured;

        SimulationManager simulationManager = (SimulationManager)GetNode("/root/SimulationManager");

        particles = (Spatial)GetNode("Particles");
        particle = (PackedScene)GD.Load("res://src/Particle3D.tscn");

        GD.Randomize();

        simulationManager.particles3d.Clear();

        for(int i = 0; i < simulationManager.particleTypes; i++) {
            for(int j = 0; j < 100 / simulationManager.particleTypes; j++) {
                Particle3D particleInstance = (Particle3D)particle.Instance();

                particleInstance.type = Convert.ToUInt32(i);

                particles.AddChild(particleInstance);
                particleInstance.Translation = new Vector3(Convert.ToSingle(GD.RandRange(-100.0, 100.0)), Convert.ToSingle(GD.RandRange(-100.0, 100.0)), Convert.ToSingle(GD.RandRange(-100.0, 100.0)));

                simulationManager.particles3d.Add(particleInstance);
            }
        }

        simulationManager.started = true;
    }
}

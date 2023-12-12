using Godot;
using Godot.Collections;
using System;

public class SimulationManager : Node2D
{
    [Signal]
    delegate void OnRuleUpdate();

    public double[,] rules;

    public int particleTypes = 10;

    public Color[] colors = {
        new Color(1, 0, 0),
        new Color(1, 0.647059f, 0),
        new Color(1, 1, 0),
        new Color(0, 1, 0),
        new Color(0, 1, 1),
        new Color(0, 0, 1),
        new Color(0.627451f, 0.12549f, 0.941176f),
        new Color(0.933333f, 0.509804f, 0.933333f),
        new Color(1, 0.752941f, 0.796078f),
        new Color(0.180392f, 0.545098f, 0.341176f),
    };

    public Array<Particle> particles = new Array<Particle>();
    public Array<Particle3D> particles3d = new Array<Particle3D>();

    public bool started;

    public float attractionRange = 2.0f;
    public float friction = 0.6f;
    public bool repulseCloseParticles = true;
    public float simulationSpeed = 1.0f;

    public override void _Ready()
    {
        GD.Randomize();

        NewRules();
    }

    public override void _Process(float delta)
    {
        Engine.TimeScale = simulationSpeed;
    }

    void NewRules() {
        rules = new double[particleTypes, particleTypes];

        for(int i = 0; i < particleTypes; i++) {
            for(int j = 0; j < particleTypes; j++) {
                rules[i, j] = i == j ? GD.RandRange(-3.0, -1.0) : GD.RandRange(-10.0, 10.0);
            }
        }
    }
}

# Baseball Flight Simulation with Aerodynamic Drag (MATLAB)

This project implements a full numerical simulation of a baseball’s 2D flight path under aerodynamic drag using MATLAB. It models coupled horizontal and vertical motion, incorporates a nonlinear drag force proportional to velocity squared, and compares the numeric trajectory against the analytic no-drag solution. The work demonstrates physical modeling, numerical integration, validation against analytic benchmarks, and data export for downstream analysis.

---

## 🚀 **Features**

* Physics-based model of baseball flight using:

  * Gravity
  * Velocity-dependent quadratic drag
  * User-specified drag coefficient
* Side-by-side comparison of:

  * **Analytic solution** (no drag)
  * **Numeric integrator** (with drag)
* Generates complete trajectory data:

  * Time (s)
  * Position (m and ft)
  * Exported to Excel via `writematrix`
* Clean visualization of drag trajectory
* Built-in numerical consistency checks when drag coefficient `C = 0`

---

## 🧠 **Physics & Modeling**

The baseball is modeled as a point mass with forces:

* **Gravity:**
  [
  F_g = -mg
  ]

* **Aerodynamic Drag:**
  [
  \vec F_d = -\tfrac{1}{2} C \rho A v, \vec v
  ]

where

* ( C ) = drag coefficient (user input)
* ( \rho ) = air density
* ( A ) = cross-sectional area of the ball
* ( v ) = instantaneous speed

The simulation integrates the coupled ODEs for horizontal and vertical motion using a forward-Euler method with velocity-dependent acceleration.

---

## 🔢 **Numerical Method**

The solver updates position and velocity at each time step:

```
vx = vx + ax*dt
vy = vy + ay*dt

x(k+1) = x(k) + vx*dt + 0.5*ax*dt^2
y(k+1) = y(k) + vy*dt + 0.5*ay*dt^2
```

Time is discretized using `linspace` with ~1000 intervals for smooth trajectories.

---

## 🧪 **Validation**

When the user enters:

```
C = 0
```

drag is disabled.
The script automatically checks:

* Numeric x(t) ≈ Analytic x(t)
* Numeric y(t) ≈ Analytic y(t)

via absolute error sums, confirming integrator correctness under no-drag conditions.

---

## 📈 **Visualization**

The script plots:

* The **numeric drag trajectory** (ft vs ft)
* Fully labeled axes
* Title with chosen drag coefficient
* Gridlines and improved readability

This allows visual analysis of drag effects on range and height.

---

## 📤 **Data Export**

A full trajectory matrix is exported to Excel:

```
M = [t, x(m), y(m), x(ft), y(ft)]
writematrix(M, 'phase3_export.xlsx')
```

This enables further analysis in MATLAB, Excel, or Python.

---

## 🗂 **Files in This Repository**

```
baseball-flight-matlab-simulation/
│
├── baseball_flight.m        # Main MATLAB script
├── phase3_export.xlsx       # Example exported data
└── README.md                # Project documentation
```

---

## 🧩 **Dependencies**

* MATLAB R2022b or later
* No additional toolboxes required

---

## 🎯 **Learning Outcomes**

This project demonstrates:

* Numerical integration of coupled ODEs
* Physics-based dynamic modeling
* Validation of numeric methods
* Data visualization and analysis
* Clean MATLAB workflow (vectors, plotting, export)

These skills are widely applicable to scientific computing, simulation, embedded sensor data analysis, and engineering R&D.

---

## 📬 **Author**

**Alex Zhang**
UMass Amherst — Electrical & Computer Engineering

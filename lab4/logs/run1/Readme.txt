Notes from lab 4:
Task 1:
Does not follow optimal trajectory very well. Not sure if quarc error or tuning error. Travel is a bit off, although not too much.
The biggest problem is that the elevation does not follow good enough, such that the constraint would not be satisfied irl.

Task 2:
This does not fit well with reality. The most important is that pitch also affects how the motors affect the elevation.
With larger pitch angle, the force component that affects the elevation gets smaller, such that the resuling elevation is off.

Also, the inertia of the helicopter will affect it's ability to change the elevation. if the helicopter spins quickly around, it's very difficult to change the elevation.

Lastly, the model is linearized around x = 0, so that any deviation from this point will cause model errors.

These modelling erros will not be taken into account when calculating the optimal trajectory.
This leads to f.eks. that the elevation rate is larger than the physical helicopter can handle (ref. Inertia and pitch angle).



One suggested fix is to perform the movement over a longer period of time (N).
This will reduce the magnitude of all the states, such that it is closer to the linearization point.

Another solution is to decople the pitch and elevation movements, such that the pitch movement does not affect the elevation,
and that when elevation is changed, the pitch is at the linearization point.
Practically, this could be done by adding more terms in the objective function: some_gain_factor*(pitch^2*elevation_rate^2) --> Minimize movement in elevation and pitch at the same time
and: some_gain_factor*(travel_rate^2*elevation_rate^2) --> Reduce movement in elevation and travel at the same time.

A third solution is to make a better model (nonlinear) and solve the nonlinear optimization problem instead. 


%% Notes from lab 2
 %{
1. Could any unwanted effects arise from steering the helicopter with this
objective function?
    Not sure. Maybe. The pitch constraint makes it impossible to stop
    quickly, as 30 degrees of pitch wont stop a fast rotating helicopter
    for some time.
2. Does the input trajectory seem reasonable?
    Yes? (Atleast the form), but maybe not the amplitude or time-length.
3. Does the helicopter end in the desired point?
    No. it does not. Helicopter starts fairly still (but with small
    rotation), then it pitches and corrects (according to input), however
    it keeps rotating forever. Results are that it doesent work at all.
    This is due to a bad model and no feedback
4. What causes the deviation?
    Bad model and no feedback.
 %}
clear; clc;
%% Initialization and model definition
init05;

delta_t = 0.25; % Sample time

% Continous model
%This model captures the dynamics of the helicopter with a PD controller
%for pitch angle. Elevation is not being modelled here.
Ac = [0     1   0           0           0           0;
      0     0  -K_2         0           0           0;
      0     0   0           1           0           0;
      0     0  -K_1*K_pp    -K_pd*K_1   0           0;
      0     0   0           0           0           1;
      0     0   0           0           -K_3*K_ep   -K_3*K_ed];

Bc = [0 0; 0 0; 0 0; K_1*K_pp 0; 0 0; 0 K_ep*K_3];

% Discrete model
Ad = Ac*delta_t+eye(6);
Bd = Bc*delta_t;


mx = size(Ad,2); % Number of states (number of columns in A)
mu = size(Bd,2); % Number of inputs(number of columns in B)

% Initial values
x0_1 = pi;                              % Lambda
x0_2 = 0;                               % r
x0_3 = 0;                               % p
x0_4 = 0;                               % p_dot
x0_5 = 0;                               % e
x0_6 = 0;                               % e dot
x0 = [x0_1 x0_2 x0_3 x0_4 x0_5 x0_6]';            % Initial values

% Time horizon and initialization
N  = 15;                                % Time horizon for states
M  = N;                                 % Time horizon for inputs
z  = zeros(N*mx+M*mu,1);                % Initialize z for the whole horizon
z0 = z;                                 % Initial value for optimization
alfa = 0.2;
beta = 20;
lambda_t = 2/3*pi;

% Bounds
ul 	    = -(30/180)*pi;                 % Lower bound on control
uu 	    = (30/180)*pi;                  % Upper bound on control

xl      = -Inf*ones(mx,1);              % Lower bound on states (no bound)
xu      = Inf*ones(mx,1);               % Upper bound on states (no bound)
xl(3)   = ul;                           % Lower bound on state x3
xu(3)   = uu;                           % Upper bound on state x3

% Generate constraints on measurements and inputs
[vlb,vub]       = gen_constraints(N, M, xl, xu, ul, uu); % hint: gen_constraints
vlb(N*mx+M*mu)  = 0;                    % We want the last input to be zero
vub(N*mx+M*mu)  = 0;                    % We want the last input to be zero

% Generate the matrix Q and the vector c (objecitve function weights in the QP problem) 
Q1 = zeros(mx,mx);
Q1(1,1) = 1;                            % Weight on state x1
Q1(2,2) = 0;                            % Weight on state x2
Q1(3,3) = 0;                            % Weight on state x3
Q1(4,4) = 0;                            % Weight on state x4
Q1(5,5) = 0;                            % Weight on state x5
Q1(6,6) = 0;                            % Weight on state x6
R1 = zeros(mu,mu);
R1(1,1) = 1;                            % q1 in lab manual
R1(2,2) = 1;                            % q2 in lab manual
Q = gen_q(Q1,R1, N, M);                 % Generate Q, hint: gen_q
c = zeros(size(Q,2),1);                 % Generate c, this is the linear constant term in the QP

%% Generate system matrixes for linear model
Aeq = gen_aeq(Ad, Bd, N, mx, mu);       % Generate A, hint: gen_aeq
beq = zeros(size(Aeq,1),1);             % Generate b
beq(1:mx) = Ad*x0;

%% Calculate K gain matrix (for feedback)
Q_LQR = diag([1, 1, 1, 1, 1, 1]);
R_LQR = diag([1, 1]);
K_fb_gain = dlqr(Ad, Bd, Q_LQR, R_LQR);

%% Solve QP problem with linear model and non-linear constraint
options = optimoptions(@fmincon, 'Algorithm', 'sqp'); % Set SQP algorithm
tic
[z,lambda] = fmincon(@(z) genCostFunc(z,Q) , z0, [], [], ...
    Aeq, beq, vlb, vub, @(c, ceq) NonLinConstraint(z, alfa, beta, lambda_t, mx, N), options);
t1=toc;

% Calculate objective value
phi1 = 0.0;
PhiOut = zeros(N*mx+M*mu,1);
for i=1:N*mx+M*mu
  phi1=phi1+Q(i,i)*z(i)*z(i);
  PhiOut(i) = phi1;
end




%% Extract control inputs and states
u  = [z(N*mx+1:N*mx+M*mu);z(N*mx+M*mu)]; % Control input from solution

x1 = [x0(1);z(1:mx:N*mx)];              % State x1 from solution
x2 = [x0(2);z(2:mx:N*mx)];              % State x2 from solution
x3 = [x0(3);z(3:mx:N*mx)];              % State x3 from solution
x4 = [x0(4);z(4:mx:N*mx)];              % State x4 from solution


num_variables = 5/delta_t;
zero_padding = zeros(num_variables,1);
unit_padding  = ones(num_variables,1);

u   = [zero_padding; u; zero_padding];
x1  = [pi*unit_padding; x1; zero_padding];
x2  = [zero_padding; x2; zero_padding];
x3  = [zero_padding; x3; zero_padding];
x4  = [zero_padding; x4; zero_padding];
x = [x1, x2, x3, x4];                   % Trajectory of all states

%% Plotting
t = 0:delta_t:delta_t*(length(u)-1);

figure(1)
subplot(511)
stairs(t,u),grid
ylabel('u')
subplot(512)
plot(t,x1.*180/pi,'m',t,x1.*180/pi,'mo'),grid
ylabel('lambda')

%% Time series for Simulink
u_timeSeries = timeseries(u,t);
x_timeSeries = timeseries(x,t);
log_name_order = ["time [s]" "Travel [rad]" "Travel rate [rad]" "pitch [rad]" "pitch rate [rad]" "elevation [rad]" "elevation rate [rad]" "u (input)" "e_ref [rad]" "Vd" "Vs" "Vf" "Vb"];
save('workspace_variables.mat');


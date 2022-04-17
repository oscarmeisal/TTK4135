clear; clc;
load('log.mat');
load('workspace_variables.mat');


%% Signal log order:
% time, Travel, Travel rate, pitch, pitch rate,
% elevation, elevation rate, u (input), e_ref,
% Vd, Vs, Vf, Vb


%% Extract logged data
t_log = SimData(1,:);
t_log(end) = [];
uOut = SimData(8,:);
uOut(end) = [];
Vd = SimData(10,:);
Vs = SimData(11,:);
Vf = SimData(12,:);
Vb = SimData(13,:);

% Filter noise
%pitchRate = lowpass(pitchRate,1);
%elevationRate = lowpass(elevationRate,1);

%% Extract optimal trajectory (from pre-runned script)
t_pre = u_timeSeries.Time';
uRef = u_timeSeries.Data';

%% Input (u) plot
inputFigHandle = figure(1);
plot(t_log, uOut, 'LineWidth', 2.0);
hold on;
plot(t_pre, uRef, 'LineWidth', 2.0);
title('Optimal input vs manipulated input');
ylabel('input [V]');
xlabel('time [s]');
legend('Actual', 'Reference');
grid;
saveas(inputFigHandle, 'lab3_run4_input.png');
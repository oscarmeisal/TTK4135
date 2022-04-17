clear; clc; close all;
load('log.mat');
load('workspace_variables.mat');


%% Signal log order:
% time, Travel, Travel rate, pitch, pitch rate,
% elevation, elevation rate, u (input), e_ref,
% Vd, Vs, Vf, Vb


%% Extract logged data
SimData(:,end) = [];
t_log = SimData(1,:);
travel = SimData(2,:);
travelRate = SimData(3,:);
pitch = SimData(4,:);
pitchRate = SimData(5,:);
elevation = SimData(6,:);
elevationRate = SimData(7,:);
uOut = SimData(8,:);
elevationRef = SimData(9,:);
Vd = SimData(10,:);
Vs = SimData(11,:);
Vf = SimData(12,:);
Vb = SimData(13,:);

% Filter noise
%pitchRate = lowpass(pitchRate,1);
%elevationRate = lowpass(elevationRate,1);

%% Extract optimal trajectory (from pre-runned script)
t_pre = x_timeSeries.Time';
travelRef = x_timeSeries.Data(:,1)';
travelRateRef =  x_timeSeries.Data(:,2)';
pitchRef =  x_timeSeries.Data(:,3)';
pitchRateRef =  x_timeSeries.Data(:,4)';

%% Travel plot
travelFigHandle = figure(1);
plot(t_log, travel, 'LineWidth', 2.0);
hold on;
plot(t_pre, travelRef, 'LineWidth', 2.0);
title('Travel');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Actual', 'Reference');
grid;
saveas(travelFigHandle, 'lab3_run2_travel.png');

%% Travel rate plot
travelRateFigHandle = figure(2);
plot(t_log, travelRate, 'LineWidth', 2.0);
hold on;
plot(t_pre, travelRateRef, 'LineWidth', 2.0);
title('Travel Rate');
ylabel('angle [rad/s]');
xlabel('time [s]');
legend('Actual', 'Reference', 'Location', 'SouthEast');
grid;
saveas(travelRateFigHandle, 'lab3_run2_travelRate.png');

%% Pitch plot
pitchFigHandle = figure(3);
plot(t_log, pitch, 'LineWidth', 2.0);
hold on;
plot(t_pre, pitchRef, 'LineWidth', 2.0);
title('Pitch');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Actual', 'Reference');
grid;
saveas(pitchFigHandle, 'lab3_run2_pitch.png');

%% Pitch rate plot
pitchRateFigHandle = figure(4);
plot(t_log, pitchRate, 'LineWidth', 2.0);
hold on;
plot(t_pre, pitchRateRef, 'LineWidth', 2.0);
title('Pitch rate');
ylabel('angle [rad/s]');
xlabel('time [s]');
legend('Actual', 'Reference');
grid;
saveas(pitchRateFigHandle, 'lab3_run2_pitchRate.png');

%% Elevation plot
elevationFigHandle = figure(5);
plot(t_log, elevation, 'LineWidth', 2.0);
hold on;
plot(t_log, elevationRef, 'LineWidth', 2.0);
title('Elevation');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Actual', 'Reference', 'Location', 'SouthEast');
grid;
saveas(elevationFigHandle, 'lab3_run2_elevation.png');

%% Elevation plot
elevationRateFigHandle = figure(6);

plot(t_log, elevationRate, 'LineWidth', 2.0);
%hold on;
%plot(t_log, elevationRateRef, 'LineWidth', 2.0);
title('Elevation rate');
ylabel('angle [rad/s]');
xlabel('time [s]');
legend('Actual'); %, 'Reference');
grid;
saveas(elevationRateFigHandle, 'lab3_run2_elevationRate.png');




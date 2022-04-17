clear; clc; close all;

%% Signal log order:
% time, Travel, Travel rate, pitch, pitch rate,
% elevation, elevation rate, u (input), e_ref,
% Vd, Vs, Vf, Vb


%% Extract data from run 2
load('run2/log.mat');
load('run2/workspace_variables.mat');
t_log_run2 = SimData(1,:);
travel_run2 = SimData(2,:);
pitch_run2 = SimData(4,:);
elevation_run2 = SimData(6,:);
elevationRef_run2 = SimData(9,:);

uOut_run2 = SimData(8,:);


t_log_run2(end) = [];
uOut_run2(end) = [];
pitch_run2(end) = [];
travel_run2(end) = [];
elevation_run2(end) = [];
elevationRef_run2(end)= [];


t_pre = u_timeSeries.Time';
uRef = u_timeSeries.Data';
travelRef = x_timeSeries.Data(:,1)';
pitchRef =  x_timeSeries.Data(:,3)';

clearvars -except t_log_run2 travel_run2 pitch_run2 ...
    elevation_run2 elevationRef_run2 uOut_run2 t_pre uRef ...
    travelRef pitchRef

%% Extract data from run 4
load('run4/log.mat');
load('run4/workspace_variables.mat');
t_log_run4 = SimData(1,:);
travel_run4 = SimData(2,:);
pitch_run4 = SimData(4,:);
elevation_run4 = SimData(6,:);
elevationRef_run4 = SimData(9,:);

uOut_run4 = SimData(8,:);

clearvars -except t_log_run2 travel_run2 pitch_run2 ...
    elevation_run2 elevationRef_run2 uOut_run2 t_pre uRef ...
    travel_run4 pitch_run4 elevation_run4 elevationRef_run4 ...
    uOut_run4 t_log_run4 travelRef pitchRef


%% Input (u) plot
inputFigHandle = figure(1);
plot(t_pre, uRef, 'LineWidth', 2.0, 'color', 'black');
hold on;
plot(t_log_run2, uOut_run2, 'LineWidth', 2.0, 'color', 'r');
plot(t_log_run4, uOut_run4, 'LineWidth', 2.0, 'color', 'b');
title('Optimal input vs manipulated input');
ylabel('u / pitch_{ref} [rad]');
xlabel('time [s]');
legend('Optimal input', 'R = 1', 'R = 50');
grid;
saveas(inputFigHandle, 'lab3_run2_run4_input_comparison.png');

%% Pitch plot
pitchFigHandle = figure(2);
plot(t_pre, pitchRef, 'LineWidth', 2.0, 'color', 'black');
hold on;
plot(t_log_run2, pitch_run2, 'LineWidth', 2.0, 'color', 'r');
plot(t_log_run4, pitch_run4, 'LineWidth', 2.0, 'color', 'b');
title('Pitch');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Reference', 'R = 1', 'R = 50');
grid;
saveas(pitchFigHandle, 'lab3_run2_run4_pitch_comparison.png');

%% Travel plot
travelFigHandle = figure(3);
plot(t_pre, travelRef, 'LineWidth', 2.0, 'color', 'black');
hold on;
plot(t_log_run2, travel_run2, 'LineWidth', 2.0, 'color', 'r');
plot(t_log_run4, travel_run4, 'LineWidth', 2.0, 'color', 'b');
title('Travel');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Reference', 'R = 1', 'R = 50');
grid;
saveas(travelFigHandle, 'lab3_run2_run4_travel_comparison.png');

%% Elevation plot
elevationFigHandle = figure(4);
plot(t_log_run4, elevationRef_run4, 'LineWidth', 2.0, 'color', 'black');
hold on;
plot(t_log_run2, elevation_run2, 'LineWidth', 2.0, 'color', 'r');
plot(t_log_run4, elevation_run4, 'LineWidth', 2.0, 'color', 'b');
title('Elevation');
ylabel('angle [rad]');
xlabel('time [s]');
legend('Reference', 'R = 1', 'R = 50', 'Location', 'SouthEast');
grid;
saveas(elevationFigHandle, 'lab3_run2_run4_elevation_comparison.png');

  
    
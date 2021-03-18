%% GNSS Project 3 - main run file
clear; clc; close all

% Read File - get solutions
file_name = 'files\ALBH00CAN_R_20201020000_01D_30S_MO_-30mins_.pos';
[solutions] = readPos(file_name);


time_vals = solutions.time(:,1) + solutions.time(:,2)/60 + solutions.time(:,3)/3600;


% Plot number of satellites against time
figure('position',[50 50 1000 600])
yyaxis left
plot(time_vals,solutions.num_sat)
ylabel('Number of Satellites'); ylim([0 25])
% Plot DOP against time
%figure('position',[50 50 1000 600])
yyaxis right
plot(time_vals,solutions.GDOP)
ylabel('GDOP'); ylim([0 5])
grid on; xlabel('Time (hr)')
title('Number of Satellites and GDOP with Time')


% Conversion from ECEF to E/N/U



%% Main run file Jeff - Lithira

clear; clc; close all

% Accurate location of stations (ECEF) HELLO
ALBH = [-2341333.1131291,3539049.53605306,4745791.2613984];
ALGO = [918129.141083288,4346071.33022714,4561977.91758169];
BAKE = [289834.290606477,2756501.17332637,5725162.39460111];
%MAL = [];
%SGO = [];
%ZIMM = [];


p = [];
files = fopen('read.txt');
while (~feof(files))   
    file_name = textscan(files,'%s',1,'Delimiter','\n');
    file_name = file_name{1,1};
    file_name = char(file_name);
    [solutions] = readPos(file_name);
    
    
    % Approximate positions
    p = [p;solutions.llh(1,2),solutions.llh(1,1)];
    
    
    % Plot number of satellites against time
    time_vals = solutions.time(:,1) + solutions.time(:,2)/60 + solutions.time(:,3)/3600;
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
    
    
    % Conversion to ENU for error
    %
    %
    
    
    
    
end


% Plot stations
load coastlines
figure()
plot(coastlon,coastlat)
hold on
plot(p(:,1),p(:,2),'r*')
xlabel('Longitude')
ylabel('Latitude')
title('Location of Stations')
hold off



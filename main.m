%% Main run file Jeff - Lithira

clear; clc; close all

% Accurate location of stations (ECEF) 
ALBH = [-2341333.1131291,-3539049.53605306,4745791.2613984];
ALGO = [918129.141083288,-4346071.33022714,4561977.91758169];
BAKE = [-289834.290606477,-2756501.17332637,5725162.39460111];
MAL = [4865385.694,4110717.189,-331137.637];
SGO = [1113280.0609,6233644.2886,760276.9549];
ZIMM = [4331297.348,567555.639,4633133.728];

count = 1;
locs = [ALBH;ALGO;BAKE;MAL;SGO;ZIMM]; 


p = [];
time_v = [];
time_h = [];
rms = [];
files = fopen('read.txt');
while (~feof(files))   
    file_name = textscan(files,'%s',1,'Delimiter','\n');
    file_name = file_name{1,1};
    file_name = char(file_name);
    [solutions] = readPos(file_name);
    
    
    % Approximate positions
    p = [p;solutions.llh(end,2),solutions.llh(end,1)];
    
    
    % Plot number of satellites against time
    time_vals = solutions.time(:,1) + solutions.time(:,2)/60 + solutions.time(:,3)/3600;
    figure('position',[50 50 1000 600])
    yyaxis left
    plot(time_vals,solutions.num_sat)
    ylabel('Number of Satellites'); ylim([0 25])
    % Plot DOP against time
    yyaxis right
    plot(time_vals,solutions.GDOP)
    ylabel('GDOP'); ylim([0 5])
    grid on; xlabel('Time (hr)')
    title('Number of Satellites and GDOP with Time')
    
    
    % Conversion to ENU for error
    lat = solutions.llh(end,1);
    lon = solutions.llh(end,2);
    exact_enu = ECEF_ENU(locs(count,1),locs(count,2),locs(count,3),lat,lon); %Exact
    enu = ECEF_ENU(solutions.ECEF(:,1),solutions.ECEF(:,2),solutions.ECEF(:,3),lat,lon);
    

    % Horizontal and Vertical Distances
    horz = sqrt((enu(:,1) - exact_enu(1)).^2 + (enu(:,2)-exact_enu(2)).^2);
    vert = sqrt((enu(:,3) - exact_enu(3)).^2);
    hv = [horz,vert];
    

    % Time Series of Horizontal and Vertical Errors
    figure()
    yyaxis left
    plot(time_vals,horz)
    ylabel('horizontal error (m)')
    yyaxis right
    plot(time_vals,vert)
    ylabel('vertical errors (m)')
    xlabel('time (hr)')
    title('Vertical and Horizontal Error Evolution')
    
    
    % Time to get less than 5 cents error
    ind = hv <= 0.05;
    v1 = find(ind(:,1)==1);
    v2 = find(ind(:,2)==1);
    
    if ~isempty(v1)
        t_h = 30*v1(1);
        time_h = [time_h;t_h,count];
    else
        time_h = [time_h;999999999,count];
    end
    
    if ~ isempty(v2)
        t_v = 30*v2(1);
        time_v = [time_v;t_v,count];
    elseif size(v1) == 0
        time_v = [time_v;999999999,count];
    end
    
    % RMS Error
    rms_val = sqrt(sum(hv.^2)/length(hv));
    rms = [rms;rms_val];
    
    count = count+1;
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



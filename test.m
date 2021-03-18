%% test thing

clear; clc; close all

files = fopen('read.txt');

while (~feof(files))   
    file_name = textscan(files,'%s',1,'Delimiter','\n');
    file_name = file_name{1,1};
    file_name = char(file_name);
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
end


%% Function converts ECEF to ENU

function [e, n, u] = ECEF_ENU(x,y,z,lat,lon)

lat = deg2rad(lat);
lon = deg2rad(lon);

% Rotation matrix
r = [-sin(lat), cos(lat), 0;
    -cos(lat)*sin(lon), -sin(lat)*sin(lon), cos(lon);
    cos(lat)*cos(lon), sin(lat)*cos(lon), sin(lon)];


val = r*[x;y;z];
e = val(1);
n = val(2);
u = val(3);
end





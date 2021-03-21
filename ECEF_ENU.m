%% Function converts ECEF to ENU

function [enu] = ECEF_ENU(x,y,z,lat,lon)

lat = deg2rad(lat);
lon = deg2rad(lon);

% Rotation matrix
r = [-sin(lat), cos(lat), 0;
    -cos(lat)*sin(lon), -sin(lat)*sin(lon), cos(lon);
    cos(lat)*cos(lon), sin(lat)*cos(lon), sin(lon)];

enu = [];
for i = 1:length(x(:))
    val = r*[x(i);y(i);z(i)];
    v1 = val(1);
    v2 = val(2);
    v3 = val(3);

    enu = [enu;v1,v2,v3];
end





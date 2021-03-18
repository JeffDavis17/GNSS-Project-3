function [e n u] = ecef_to_enu(x,y,z,lat,lon,h)

% Earth Params
a = 6378137;
b = 6356752.3142;
f = (a-b)/a;
e = f*(2-f);

% Conversion
N = a/sqrt(1 - e*sind(lat)*sind(lat));

dx = x; %- (h+N)*cosd(lat)*cosd(lon);
dy = y; %- (h+N)*cosd(lat)*sind(lon);
dz = z; %- (h + (1-e)*N)*sind(lat);

e = -dx*sind(lat) + dy*cosd(lat);
n = -dx*cosd(lat)*sind(lon) - dy*sind(lat)*sind(lon) + dz*cosd(lon);
u = dx*cosd(lat)*cosd(lon) + dy*sind(lat)*cosd(lon) + dz*sind(lon);
end
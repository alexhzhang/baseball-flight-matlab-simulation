% Alex Zhang
% 11/19/2025
% Baseball trajectory with drag:
% compare no-drag analytic solution vs numeric with user coef drag input
% numeric trajectory includes drag; analytic trajectory is no-drag, and 
% export numeric trajectory to excel using writematrix

clear              % clear workspace to catch mistakes
clf                % clear current figure
disp(datetime)     % timestamp for script execution
format shortG

% ----- givens (all as variables, with units) -----
v0M = 116.9;        % exit speed (mph)
thetaD = 33;          % launch angle (degrees)
g = 9.8;          % gravitational acceleration (m/s^2)
m = 0.146;        % mass of baseball (kg)

mphtomps = (5280*12*2.54/100)/3600;    % conversion from mph to m/s
mtoft = 100/(2.54*12);    % conversion from meters to feet

v0 = v0M*mphtomps;          % initial speed (m/s)
thetaR = thetaD*pi/180;    % launch angle (radians)

v0x = v0*cos(thetaR);         % initial velocity in x (m/s)
v0y = v0*sin(thetaR);         % initial velocity in y (m/s)

timeFlight = 2*v0y/g;     % analytic time of flight (s)

% ----- user input: drag coefficient -----
C = input('Enter drag coefficient C (e.g., 0 or 0.35): ');

% ----- pre-calculated drag constants -----
rho = 1.225;          % air density (kg/m^3)
r = 0.0366;         % baseball radius (m)
A = pi * r^2;        % cross-sectional area (m^2)
kD = 0.5*C*rho*A;        % drag factor (kg/m), used in F = -k*v*v_x/y

nIntervals = 1000;                 % number of time intervals (>= 400)
nPoints    = nIntervals+1;       % length of arrays = 1 + intervals

t = linspace(0, timeFlight, nPoints); % time array (s), defined efficiently
dt = t(2)-t(1);                  % time step (s)

% ----- analytic (no drag) for plotting -----
xAna = v0x*t*mtoft;      % horizontal position (ft)
yAna = (v0y*t - 0.5*g * t.^2)*mtoft;   % vertical position (ft)

% ----- numeric with drag -----
x = zeros(1,nPoints);   % hori position (m)
y = zeros(1,nPoints);  % vert position (m)
vx = v0x;                          % current velocity in x (m/s)
vy = v0y;                          % current velocity in y (m/s)

for k = 1:nIntervals
    v = sqrt(vx^2 + vy^2);     % speed (m/s)
    
    % drag force components
    fxD = -kD*v*vx; % drag force in x (N)
    fyD = -kD*v*vy; % drag force in y (N)
    
    % net forces
    fx = fxD;              % no horizontal gravity (N)
    fy = -m*g + fyD;       % gravity + drag (N)
    
    % accel
    ax = fx/m; % acceleration in x (m/s^2)
    ay = fy/m; % acceleration in y (m/s^2)
    
    % position update
    x(k+1) = x(k) + dt*vx + 0.5 * dt^2 * ax; %x-position (m)
    y(k+1) = y(k) + dt*vy + 0.5 * dt^2 * ay;  % y-position (m)
    
    % velocity update
    vx = vx + dt*ax; % updated x-velocity (m/s)
    vy = vy + dt*ay; % updated y-velocity (m/s)
end

% convert to ft
xF = x*mtoft; % numeric horizontal position (ft)
yF = y*mtoft; % numeric vertical position (ft)

% ----- CHECK FOR C = 0 -----
% Must show numeric ≈ analytic
if C == 0
    xCheck = sum(abs(xF-xAna))   % should be close to zero (ft)
    yCheck = sum(abs(yF-yAna))    % should be close to zero (ft)
end


% ----------- Build export matrix for Excel ------
% with columns: t(s), x(m), y(m), x(ft), y(ft)
M = [t'  x'  y'  xF'  yF']; %units in sec, m, m, ft, ft, respectively

writematrix(M, 'phase3_export.xlsx');   % export using writematrix

% plot only numeric drag trajectory
plot(xF, yF, 'r', 'LineWidth', 2)  
%-------------phase 3 end-----------
ax = gca;
ax.FontSize = 12;
ax.XAxis.Label.FontSize = 14;
ax.YAxis.Label.FontSize = 14;

grid on
grid minor
ax.GridAlpha = 0.4;
ax.MinorGridAlpha = 0.5;

xlabel('Horizontal distance x (ft)')
ylabel('Vertical distance y (ft)')
title(['ECE 202 Project 2 Phase 3: Numeric Drag Trajectory (C = ' num2str(C) ')'], ...
       'FontSize', 16)

legend(['Numeric trajectory with drag, C = ' num2str(C)], ...
       'Location','best', 'FontSize', 14)

clc;
clear;

%% main parameteres
bar_length = 2; % meters
forces = randi([-15 15],10,1); % newtons


fposx = randi([-15 15],10,1); % meters
fposy = randi([0 0],10,1); % meters
fpos = [fposx fposy];

pivpos = [0 0]; % position of pivot point

distance = abs(fpos-pivpos);

n = size(forces,1);
torques = zeros(n,2);


%% for loop to create torque matrix
for i = 1:n
    torques(i) = (forces(i)*fpos(i))*-1;
end

net_torque = sum(sum(torques));
net_torque_matrix = sum(torques);


%% if statement to check for net direction
if net_torque > 0 

    fprintf('The system is experiencing a torque of %.2f Newtons Counter-Clockwise. \n', abs(net_torque))

elseif net_torque < 0

    fprintf('The system is experiencing a torque of %.2f Newtons Clockwise. \n', abs(net_torque))

else

    fprintf('The system is in equilibrium, with no net torque.');

end

%% plotting
figure;
hold on;
grid on;
xlabel('Position along bar (m)');
ylabel('Force / Arrow (scaled)');

plot([-15 15], [0 0], 'k-', 'LineWidth',2); 

scale = 0.1; % to scale forces visually
quiver(fposx, fposy, zeros(n,1), forces * scale, 2, 'r', 'LineWidth',2);

% labels for all forces
for i = 1:n
    label = [num2str(forces(i)) ' N'];
    text(fposx(i)+0.35, forces(i)+0.35, label, 'FontSize',9);
end

% pivot marker
plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',8);

% if statement to check for net direction
if net_torque > 0
    summary = sprintf('Net Torque: %.2f Nm (CCW)', abs(net_torque));
elseif net_torque < 0
    summary = sprintf('Net Torque: %.2f Nm (CW)', abs(net_torque));
else
    summary = 'Net Torque: 0 Nm (Equilibrium)';
end

% display at a fixed spot
xSummary = -14;
ySummary = max(forces*scale)+2;

text(xSummary, ySummary, summary, 'FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'w');


title('Random Force Diagram Along Beam');

%% extra displayable data for the command window
torques;
forces;
fpos;
net_torque;





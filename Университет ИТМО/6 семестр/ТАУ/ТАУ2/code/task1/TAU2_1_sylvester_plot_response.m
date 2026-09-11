clc; clear; close all;

%% исходные данные
A = [5  8  5;
    -6 -9 -8;
     6  6  5];

B = [2; 0; 0];

K = [-5.0000, -5.0000, -3.8333];

z = A + B*K;

disp('Собственные числа замкнутой системы:');
disp(eig(z));

%% моделирование
x0 = [1; 1; 1];
time_vec = linspace(0, 5, 1000);
[t_sim, x1] = ode45(@(t,x) z*x, time_vec, x0);
u1 = (K * x1')';

%% построение графиков
colors = [0.85, 0.25, 0.25;    % x1 - красный
          0.95, 0.65, 0.15;    % x2 - оранжевый
          0.15, 0.45, 0.75;    % x3 - голубой
          0.15, 0.45, 0.75];   % u  - голубой

T = 14; M = 18; L = 16;

% --- график состояний x(t) ---
fig1 = figure('Color','white','Position',[100 100 900 450]); hold on
plot(t_sim, x1(:,1), 'LineWidth', 2.5, 'Color', colors(1,:))
plot(t_sim, x1(:,2), 'LineWidth', 2.5, 'Color', colors(2,:))
plot(t_sim, x1(:,3), 'LineWidth', 2.5, 'Color', colors(3,:))
hold off

ax = gca;
ax.LineWidth = 0.8;
ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.5;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.3;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$x(t)$','Interpreter','latex','FontSize',M)
xlim([-0.01; 5.01]); ylim([-2.8; 3.3]);   
legend('$x_1$','$x_2$','$x_3$','Interpreter','latex','Location','northeast','FontSize',L)
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

% сохраним график состояния
exportgraphics(fig1, 'TAU2_2_State_Sylvester.png'); 


% --- график управления u(t) ---
fig2 = figure('Color','white','Position',[100 100 900 450]); hold on
plot(t_sim, u1, 'LineWidth', 2.5, 'Color', colors(4,:))
hold off

ax = gca;
ax.LineWidth = 0.8;
ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.5;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.3;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$u(t)$','Interpreter','latex','FontSize',M)
xlim([-0.01; 5.01]); ylim([-14; 4]);     
legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',L)
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

% сохраним график управления
exportgraphics(fig2, 'TAU2_1_Control_Sylvester.png'); 
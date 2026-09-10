clear; clc; close all;

%% исходные данные
A = [-9 0 -10; -4 -1 -6; 6 -2 5];
C = [2 -1 2]; 
t1 = 3;

f = @(t) -3*exp(-3*t).*cos(2*t) - 2*exp(-3*t).*sin(2*t);

%% вычисление Грамиана наблюдаемости
Q = integral(@(t) expm(A'*t)*C'*C*expm(A*t), 0, t1, 'ArrayValued', true);

%% вычисление начальных условий
I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
x0 = inv(Q)*I;

disp('Начальные условия x(0):');
disp(x0);

%% решение ОДУ
tspan = linspace(0, t1, 1000);
[t, x] = ode45(@(t, x) A*x, tspan, x0);

%% вычисление выхода
y = (C*x')';
y_ref = f(t);

%% параметры оформления
colors = lines(7);
T = 12; M = 14; L = 12;

%% график y(t) и f(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t, y, 'LineWidth', 2.5, 'Color', colors(2,:))
plot(t, y_ref, '--', 'LineWidth', 2.5, 'Color', colors(3,:))

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = T; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];
ax.TickDir = 'out';

grid on; 
box on; 
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);
y_max = max(abs([y; y_ref]));
ylim([-1.2*y_max, 1.2*y_max]);

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$y(t)$','Interpreter','latex','FontSize',M)
legend('$y(t)$', '$f(t)$', 'Interpreter','latex', 'Location','best', 'FontSize',L);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

%% график ошибки e(t) = y(t) - f(t)
e = y - y_ref;

figure('Color','white','Position',[100 100 900 350]); hold on
plot(t, e, 'LineWidth', 2.5, 'Color', colors(1,:))

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = T; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];
ax.TickDir = 'out';

grid on; 
box on; 
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);
e_max = max(abs(e));
if e_max < 1e-15
    e_max = 1e-5;
end
ylim([-1.5*e_max, 1.5*e_max]);
ax.YAxis.Exponent = -3;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$e(t)$','Interpreter','latex','FontSize',M)
legend('$e(t)=y(t)-f(t)$', 'Interpreter','latex', 'Location','best', 'FontSize',L);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
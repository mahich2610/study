clear; clc; close all;

%% исходные данные
A = [-9 0 -10; -4 -1 -6; 6 -2 5];
C = [0 -5 -5];
t1 = 3;

f = @(t) -3*exp(-3*t).*cos(2*t) - 2*exp(-3*t).*sin(2*t);

%% вычисление Грамиана наблюдаемости
Q = integral(@(t) expm(A'*t)*C'*C*expm(A*t), 0, t1, 'ArrayValued', true);

%% вычисление начальных условий через псевдообратную матрицу
I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
x0_original = pinv(Q)*I;  % Псевдообратная матрица

disp('=== Начальные условия x(0), вычисленные через Грамиан ===')
disp(x0_original)

%% находим ядро матрицы наблюдаемости
V = obsv(A, C);
null_V = null(V);

disp('=== Ядро матрицы наблюдаемости ===')
disp('Базисный вектор v:')
disp(null_V)

%% строим ЧЕТЫРЕ различных начальных условия
alpha1 = 0;
alpha2 = 1;
alpha3 = 2;
alpha4 = -1;

x0_1 = x0_original + alpha1 * null_V;
x0_2 = x0_original + alpha2 * null_V;
x0_3 = x0_original + alpha3 * null_V;
x0_4 = x0_original + alpha4 * null_V;

disp(' ')
disp('Четыре различных начальных условия:')
disp('x0_1 (исходное) ='); disp(x0_1)
disp('x0_2 ='); disp(x0_2)
disp('x0_3 ='); disp(x0_3)
disp('x0_4 ='); disp(x0_4)

%% моделирование
tspan = linspace(0, t1, 1000);

[t1_sol, x1_sol] = ode45(@(t,x) A*x, tspan, x0_1);
[t2_sol, x2_sol] = ode45(@(t,x) A*x, tspan, x0_2);
[t3_sol, x3_sol] = ode45(@(t,x) A*x, tspan, x0_3);
[t4_sol, x4_sol] = ode45(@(t,x) A*x, tspan, x0_4);

y1 = (C * x1_sol')';
y2 = (C * x2_sol')';
y3 = (C * x3_sol')';
y4 = (C * x4_sol')';
y_ref = f(tspan)';

%% ГРАФИКИ

%% рисунок 1 все выходы y(t)
figure('Color','white','Position',[100 100 900 400]); hold on

plot(tspan, y_ref, '-', 'LineWidth', 3, 'Color', [0 0.4470 0.7410 0.5])
plot(tspan, y1, '--', 'LineWidth', 3, 'Color', [0.8500 0.3250 0.0980 0.5])
plot(tspan, y2, ':', 'LineWidth', 3, 'Color', [0.4660 0.6740 0.1880 0.5])
plot(tspan, y3, '-.', 'LineWidth', 3, 'Color', [0.9290 0.6940 0.1250 0.5])
plot(tspan, y4, '--', 'LineWidth', 3, 'Color', [0.4940 0.1840 0.5560 0.5])

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = 12; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];

grid on; box on;
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);

y_max = max([max(abs(y1)), max(abs(y2)), max(abs(y3)), ...
             max(abs(y4)), max(abs(y_ref))]);
ylim([-1.2*y_max, 1.2*y_max]);

xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$y(t)$','Interpreter','latex','FontSize',14)
legend('$f(t)$', '$x_1(0)$', '$x_2(0)$', '$x_3(0)$', '$x_4(0)$', ...
    'Interpreter','latex', 'Location','best', 'FontSize',10);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

%% рисунок 2: компонента x_1(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(tspan, x1_sol(:,1), 'LineWidth', 3, 'Color', [0 0.4470 0.7410])
plot(tspan, x2_sol(:,1), '--', 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980])
plot(tspan, x3_sol(:,1), ':', 'LineWidth', 2.5, 'Color', [0.9290 0.6940 0.1250])
plot(tspan, x4_sol(:,1), '-.', 'LineWidth', 2.5, 'Color', [0.4940 0.1840 0.5560])

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = 12; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];

grid on; box on;
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);
xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$x_1(t)$','Interpreter','latex','FontSize',14)
legend('$x_1(0)$', '$x_2(0)$', '$x_3(0)$', '$x_4(0)$', ...
    'Interpreter','latex', 'Location','best', 'FontSize',10);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

%% рисунок 3: компонента x_2(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(tspan, x1_sol(:,2), 'LineWidth', 3, 'Color', [0 0.4470 0.7410])
plot(tspan, x2_sol(:,2), '--', 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980])
plot(tspan, x3_sol(:,2), ':', 'LineWidth', 2.5, 'Color', [0.9290 0.6940 0.1250])
plot(tspan, x4_sol(:,2), '-.', 'LineWidth', 2.5, 'Color', [0.4940 0.1840 0.5560])

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = 12; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];

grid on; box on;
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);
xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$x_2(t)$','Interpreter','latex','FontSize',14)
legend('$x_1(0)$', '$x_2(0)$', '$x_3(0)$', '$x_4(0)$', ...
    'Interpreter','latex', 'Location','best', 'FontSize',10);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

%% рисунок 4: компонента x_3(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(tspan, x1_sol(:,3), 'LineWidth', 3, 'Color', [0 0.4470 0.7410])
plot(tspan, x2_sol(:,3), '--', 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980])
plot(tspan, x3_sol(:,3), ':', 'LineWidth', 2.5, 'Color', [0.9290 0.6940 0.1250])
plot(tspan, x4_sol(:,3), '-.', 'LineWidth', 2.5, 'Color', [0.4940 0.1840 0.5560])

ax = gca; 
ax.LineWidth = 0.8;
ax.FontSize = 12; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.TickLength = [0 0];

grid on; box on;
ax.GridLineStyle = ':';
ax.GridColor = [0.7 0.7 0.7];
ax.GridAlpha = 0.6;

xlim([0, t1]);
xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$x_3(t)$','Interpreter','latex','FontSize',14)
legend('$x_1(0)$', '$x_2(0)$', '$x_3(0)$', '$x_4(0)$', ...
    'Interpreter','latex', 'Location','best', 'FontSize',10);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
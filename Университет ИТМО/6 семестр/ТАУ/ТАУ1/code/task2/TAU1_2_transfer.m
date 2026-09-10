clc; clear; close all;

% исходные данные
A = [1 2 -1; -6 -7 -2; 6 6 1];
B = [-2; 4; -2];
x1 = [2; -3; 3];
t1 = 3;

% матрица управляемости
U = ctrb(A, B);
rank_U = rank(U);
det_U = det(U);

% собственные числа
eig_A = eig(A);

% грамиан управляемости
Wc = lyap(A, B*B');

% управление
syms t
u = B' * expm(A' * (t1 - t)) * inv(Wc) * x1;

% моделирование
t_span = 0:0.01:t1;
u_num = zeros(size(t_span));
for i = 1:length(t_span)
    u_num(i) = double(subs(u, t, t_span(i)));
end

% решение дифференциального уравнения
[t_sol, x_sol] = ode45(@(t,x) A*x + B*interp1(t_span, u_num, t), t_span, [0; 0; 0]);

%% параметры оформления
colors = lines(7);
T = 12; M = 14; L = 12;

%% график 1: управляющее воздействие u(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t_span, u_num, 'LineWidth', 2.5, 'Color', colors(1,:))

xline(t1, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');

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

xlim([0, t1 + 0.3]);

% автоматические отступы по Y для u(t)
u_max = max(abs(u_num));
ylim([-1.2*u_max, 1.2*u_max]);

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$u(t)$','Interpreter','latex','FontSize',M)
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

%% график 2: компоненты вектора состояния x(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t_sol, x_sol(:,1), 'LineWidth', 2.5, 'Color', colors(1,:))
plot(t_sol, x_sol(:,2), 'LineWidth', 2.5, 'Color', colors(2,:))
plot(t_sol, x_sol(:,3), 'LineWidth', 2.5, 'Color', colors(3,:))

xline(t1, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
yline(x1(1), '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
yline(x1(2), '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
yline(x1(3), '--k', 'LineWidth', 1, 'HandleVisibility', 'off');

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

xlim([0, t1 + 0.3]);

% находим максимальное и минимальное значения среди всех x(t)
x_max = max(x_sol(:));
x_min = min(x_sol(:));
margin = 0.3 * max(abs(x_max), abs(x_min));  % Отступ 30%
ylim([x_min - margin, x_max + margin]);
% ============================

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$x(t)$','Interpreter','latex','FontSize',M)
legend('$x_1$', '$x_2$', '$x_3$', ...
    'Interpreter','latex', 'Location','best', 'FontSize',L);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

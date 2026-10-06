% вариант 17
n = 17;

% генерация параметров по методичке
rng(n, "philox");
M  = randi([100000 1000000]) / 1000 / sqrt(2);
m1 = randi([1000 10000]) / 1000 * sqrt(3);
m2 = randi([1000 10000]) / 1000 * sqrt(3);
l  = randi([100 1000]) / sqrt(5) / 100;

g = 9.81; % ускорение свободного падения

% вспомогательные параметры
m  = m1 + m2;
lc = (m1 * l/2 + m2 * l) / m;
J  = (1/3) * m1 * l^2 + m2 * l^2;

% определитель матрицы инерции в точке линеаризации
Delta0 = (M + m) * J - (m * lc)^2;

% матрицы линеаризованной модели
A = [0, 1, 0, 0;
     0, 0, -(m*lc)^2 * g / Delta0, 0;
     0, 0, 0, 1;
     0, 0, (M + m) * m * lc * g / Delta0, 0];

B = [0;
     J / Delta0;
     0;
     -m * lc / Delta0];

D = [0;
     -m * lc / Delta0;
     0;
     (M + m) / Delta0];

C = [1 0 0 0;
     0 0 1 0];

% вывод результатов
fprintf('=== Параметры системы (вариант %d) ===\n', n);
fprintf('M  = %.4f кг\n', M);
fprintf('m1 = %.4f кг\n', m1);
fprintf('m2 = %.4f кг\n', m2);
fprintf('l  = %.4f м\n', l);
fprintf('g  = %.2f м/с^2\n', g);
fprintf('\n');
fprintf('=== Вспомогательные параметры ===\n');
fprintf('m   = %.4f кг\n', m);
fprintf('lc  = %.4f м\n', lc);
fprintf('J   = %.4f кг*м^2\n', J);
fprintf('Delta0 = %.4f\n', Delta0);
fprintf('\n');
fprintf('=== Матрица A ===\n');
disp(A);
fprintf('=== Матрица B ===\n');
disp(B);
fprintf('=== Матрица D ===\n');
disp(D);
fprintf('=== Матрица C ===\n');
disp(C);
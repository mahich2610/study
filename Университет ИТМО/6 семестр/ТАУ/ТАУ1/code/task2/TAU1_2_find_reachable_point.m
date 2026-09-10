clc; clear;

% матрицы
A = [1 2 -1; -6 -7 -2; 6 6 1];
B = [2; 0; 0];  % <- новая матрица B

% проверяемые точки
x1_prime = [2; -3; 3];
x1_double_prime = [1; -2; 3];

% матрица управляемости
U = ctrb(A, B);
rank_U = rank(U);

disp('=== Матрица управляемости U ===');
disp('U = [B  A*B  A^2*B] =');
disp(U);
disp(['rank(U) = ', num2str(rank_U)]);
disp(' ');

disp('=== Проверка принадлежности точек ===');

% проверка первой точки
U_x1_prime = [U x1_prime];
rank_1 = rank(U_x1_prime);
disp('Точка x1'' = [2; -3; 3]:');
disp('[U x1''] =');
disp(U_x1_prime);
disp(['rank([U x1'']) = ', num2str(rank_1)]);
if rank_1 == rank_U
    disp('-> ПРИНАДЛЕЖИТ управляемому подпространству');
else
    disp('-> НЕ принадлежит');
end
disp(' ');

% проверка второй точки
U_x1_double_prime = [U x1_double_prime];
rank_2 = rank(U_x1_double_prime);
disp('Точка x1'''' = [1; -2; 3]:');
disp('[U x1''''] =');
disp(U_x1_double_prime);
disp(['rank([U x1'''']) = ', num2str(rank_2)]);
if rank_2 == rank_U
    disp('-> ПРИНАДЛЕЖИТ управляемому подпространству');
else
    disp('-> НЕ принадлежит');
end
disp(' ');

% выбор целевой точки
if rank_1 == rank_U
    x1 = x1_prime;
    disp('Выбрана целевая точка: x1 = x1''');
    disp(x1);
elseif rank_2 == rank_U
    x1 = x1_double_prime;
    disp('Выбрана целевая точка: x1 = x1''''');
    disp(x1);
else
    disp('ОШИБКА: Ни одна точка не принадлежит!');
end
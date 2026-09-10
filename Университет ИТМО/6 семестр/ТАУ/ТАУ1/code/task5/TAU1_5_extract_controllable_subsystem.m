clc; clear;

A = [1 2 -1;
    -6 -7 -2;
     6 6 1];

B = [-2; 4; -2];

C = [0 1 -1;
     0 -3 3];

%% D = 0 (исходный случай)
D1 = zeros(2,1);

Wy1 = [C*B, C*A*B, C*A^2*B];
r1 = rank(Wy1);

disp('D = 0')
disp(Wy1)
fprintf('rank = %d\n\n', r1);

%% D != 0 (улучшение)
D2 = [0; 1];

Wy2 = [D2, C*B, C*A*B, C*A^2*B];
r2 = rank(Wy2);

disp('D = [0;1]')
disp(Wy2)
fprintf('rank = %d\n', r2);

p = size(C,1);

if r2 == p
    disp('Система стала полностью управляема по выходу')
else
    disp('Система НЕ управляема по выходу')
end
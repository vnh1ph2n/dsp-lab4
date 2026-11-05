clc; clear; close;

// tin hieu vao: x(n) va h(n)
x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);

// phuong phap 1: folding & shifting (dich vong modulo)
y_fold = zeros(1, N);
for n = 0:N-1
    for k = 0:N-1
        idx = pmodulo(n - k, N) + 1;
        y_fold(n + 1) = y_fold(n + 1) + h(k + 1) * x(idx);
    end
end

// phuong phap 2: ma tran xoay vong (circulant matrix)
H_circ = zeros(N, N);
for i = 1:N
    for j = 1:N
        idx = pmodulo(i - j, N) + 1;
        H_circ(i, j) = h(idx);
    end
end
y_mat = (H_circ * x')';

// tinh nang luong: x(n) va y(n)
E_x = cumsum(x.^2);
E_y = cumsum(y_fold.^2);

// ve do thi: x(n), y(n) va nang luong
scf(0); clf();

subplot(3, 1, 1);
plot2d3(0:N-1, x, 2); title("tin hieu vao x(n)"); xgrid();

subplot(3, 1, 2);
plot2d3(0:N-1, y_fold, 3); title("tich chop vong y(n)"); xgrid();

subplot(3, 1, 3);
plot(0:N-1, E_x, "r-o"); plot(0:N-1, E_y, "b-s");
title("nang luong tich luy E_x va E_y"); legend(["E_x"; "E_y"]); xgrid();

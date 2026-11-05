clc; clear; close;

// tin hieu vao: x(n) va h(n)
x = [1, 2, -3, 2, 1];
h = [1, 0, -1];

// phuong phap 1: folding & shifting (vong lap nhan tich chop)
Nx = length(x);
Nh = length(h);
Ny = Nx + Nh - 1;
y_fold = zeros(1, Ny);

for n = 1:Ny
    for k = 1:Nh
        if (n - k + 1 >= 1) & (n - k + 1 <= Nx) then
            y_fold(n) = y_fold(n) + h(k) * x(n - k + 1);
        end
    end
end

// phuong phap 2: ma tran toeplitz
H_mat = zeros(Ny, Nx);
for i = 1:Nx
    H_mat(i : i + Nh - 1, i) = h';
end
y_mat = (H_mat * x')';

// tinh nang luong: x(n) va y(n)
E_x = cumsum(x.^2);
E_y = cumsum(y_fold.^2);

// ve do thi: x(n), y(n) va nang luong
scf(0); clf();

subplot(3, 1, 1);
plot2d3(0:Nx-1, x, 2); title("tin hieu vao x(n)"); xgrid();

subplot(3, 1, 2);
plot2d3(0:Ny-1, y_fold, 3); title("tich chop y(n)"); xgrid();

subplot(3, 1, 3);
plot(0:Nx-1, E_x, "r-o"); plot(0:Ny-1, E_y, "b-s");
title("nang luong tich luy E_x va E_y"); legend(["E_x"; "E_y"]); xgrid();

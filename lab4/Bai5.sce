clc; clear; close;

// nap ipcv
if ~isdef("imhistequal") then
    atomsLoad("IPCV");
end

// tao anh mau: luoi toa do | anh xam 8-bit
[X, Y] = meshgrid(1:256, 1:256);
img_gray = uint8(100 + 80 * sin(X/10) .* cos(Y/10)); 

// thuat toan: can bang histogram | bo loc mo 5x5 | tich chop
img_eq = imhistequal(img_gray);
h_blur = fspecial("average", 5);
img_blur = imfilter(img_gray, h_blur);

// du lieu histogram: trich xuat toa do | tranh mo cua so rieng
[counts_gray, cells_gray] = imhist(img_gray);
[counts_eq, cells_eq]     = imhist(img_eq);
[counts_blur, cells_blur] = imhist(img_blur);

// ve do thi
scf(0); clf();

subplot(2, 3, 1); imshow(img_gray); title("1. Anh goc");
subplot(2, 3, 2); imshow(img_eq);   title("2. Anh can bang Histogram");
subplot(2, 3, 3); imshow(img_blur); title("3. Anh lam mo");

subplot(2, 3, 4); plot(cells_gray, counts_gray, "b"); title("Histogram goc");
subplot(2, 3, 5); plot(cells_eq, counts_eq, "r");     title("Histogram can bang");
subplot(2, 3, 6); plot(cells_blur, counts_blur, "g"); title("Histogram anh mo");

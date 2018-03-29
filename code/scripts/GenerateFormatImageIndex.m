%% Generate Card mif index data
clear; format short;

%% Constants
MAX_H = 480;
MAX_W = 640;

%% Load image
filename = 'cards.png';
RGB = rgbImage(filename);

%% Truncate and format
height = min( MAX_H, size(RGB, 1));
width  = min( MAX_W, size(RGB, 2));

padding = [MAX_H - height, MAX_W - width];
background = padarray(RGB(1:height, 1:width, :), padding, 'replicate', 'post');

imshow(background)

%% Concatenate RGB
load('ColorMap');

image_data = zeros(MAX_H, MAX_W,'uint32');
R = background(:, :, 1);
G = background(:, :, 2);
B = background(:, :, 3);
for i = 1:size(background, 1)
    for j = 1:size(background, 2)
        color_key = typecast([R(i, j), G(i, j), B(i, j), 0], 'uint32');
        image_data(i, j) = colorToIndexMap(color_key);
    end
end

%% Flatten
N = MAX_H * MAX_W;
back_flat = reshape(image_data', N, 1);

%% Write to mif
image_depth = 640*480;
image_width = 2;
mif_filename = 'v_mem.mif';

writeMif(mif_filename, back_flat, image_depth, image_width);

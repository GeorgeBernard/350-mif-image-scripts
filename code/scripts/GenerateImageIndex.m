%% Index image by color map
clear; format short;

%% Get image and flatten it
file = '42.png';
load('ColorMap');
[image_data, rows, cols] = indexImage(file, colorToIndexMap);
N = rows * cols;

%% Synthesize image back from indirection
RGB_raw_vec = zeros(N, 1);
for i = 1:N
    RGB_raw_vec(i) = indexToColorMap(image_data(i));
end

% reshape matrix and transpose in order to preserve original structure
RGB_matrix = reshape(RGB_raw_vec, cols, rows)';

%% Synthesize image by splitting RGB into channels
RGB_synth = zeros(rows, cols, 3);

for i = 1:rows
    for j = 1:cols
        pixel_RGB = typecast(uint32(RGB_matrix(i, j)), 'uint8');
        R = pixel_RGB(1);
        G = pixel_RGB(2);
        B = pixel_RGB(3);
        RGB_synth(i, j, :) = [R, G, B];
    end
end

% Synthesize image
figure(3); clf; imshow(uint8(RGB_synth));

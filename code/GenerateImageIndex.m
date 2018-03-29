%% Index image by color map
clear; format short;

%% Get image and flatten it
file = 'cards.png';
load('ColorMap');
[image_data, rows, cols] = indexImage(file, colorToIndexMap);
N = rows * cols;

%% Synthesize image back from indirection
RGB_synth = zeros(N, 3, 'uint8');

for i = 1:N
   curr_RGB_raw = indexToColorMap(image_data(i));
   pixel_RGB = typecast(uint32(curr_RGB_raw), 'uint8');
   synth_R = pixel_RGB(1);
   synth_G = pixel_RGB(2);
   synth_B = pixel_RGB(3);
   RGB_synth(i, :) = [synth_R, synth_G, synth_B];
end

% Synthesize image
image_synth = reshape(RGB_synth, rows, cols, 3);
figure(3); clf; imshow(image_synth);

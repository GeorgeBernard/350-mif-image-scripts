function [ image_data, rows, cols ] = indexImage( filename, colorMap )
%% Index image with colormap as layer of indirection
%% Get im
[RGB, rows, cols] = flattenImage(filename);
N = rows*cols;

%% Create level of indirection through ColorMap
image_data = zeros(N, 1,'uint32');
R = RGB(:, 1);
G = RGB(:, 2);
B = RGB(:, 3);
for i = 1:N
    color_key = typecast([R(i), G(i), B(i), 0], 'uint32');
    image_data(i) = colorMap(color_key);
end


end


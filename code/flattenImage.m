function [ pixels, rows, columns ] = flattenImage( image_filename )
%FLATTENIMAGE Flattens image into uint32 0x00rrggbb vector
%   Loads image, gets rgb values, and puts each pixel into a vector
%   Returns the rows and columns to allow lossless reshaping

    img = imread(image_filename);
    
    % Extract RED, GREEN and BLUE components from the image
    % R = 1, G = 2, B = 3
    RGB_float = img(:,:,1:3);
    RGB       = uint8(RGB_float); % float -> uint8

    % Reshape RGB into 3 x N matrix (N is rows*columns)
    rows = size(RGB, 1);
    columns = size(RGB, 2);
    N = rows * columns;
    RGB_flat = reshape(RGB, N, size(RGB, 3));

    pixels = RGB_flat;
end


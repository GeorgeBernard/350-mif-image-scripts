function [ data_vec, rows, cols ] = makeImageDataVector( filename, colorToIndexMap )

%% Get image data stream
[image_data_stream, rows, cols] = indexImage(filename, colorToIndexMap);

%% Consolidate rows and columns to one vector
height16 = uint16(rows-1);
width16 = uint16(cols-1);

size_data = typecast([width16, height16], 'uint32');

data_vec = cat(size_data, image_data_stream);

end


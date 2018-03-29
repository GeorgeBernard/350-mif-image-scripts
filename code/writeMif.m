function [] = writeMif( filename, data_vec, depth, width)

%% Calculate padding
addr_pad = ceil(log2(depth)/4);
data_pad = ceil(width/4);

%% Write prefix header to file
file = fopen(filename, 'w');
fprintf(file, '-- file: %s\n', filename);

fprintf(file, 'WIDTH=%i\n'  , width);
fprintf(file, 'DEPTH=%i\n\n', depth);

fprintf(file, 'ADDRESS_RADIX=HEX\n');
fprintf(file, 'DATA_RADIX=HEX\n\n');

%% Write data payload to file
fprintf(file, 'CONTENT BEGIN\n');
for i = 1:min(length(data_vec), depth)
    fprintf(file, '%0*X : %0*X\n',          ...
        addr_pad,  i,                       ...
        data_pad, data_vec(i)               ...
        );
end
if length(data_vec) < depth
    fprintf(file, '[%0*X..%0*X] : %X\n',    ...
        addr_pad, i+1,                      ...
        addr_pad, depth-1,                  ...
        hex2dec(repmat('f', 1, data_pad))   ...
        );
end

%% Finish Write
fprintf(file, 'END');
fclose(file);

end


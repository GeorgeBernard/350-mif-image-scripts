function [] = writeMif( filename, data_vec, depth, width, comments)

%% Calculate padding
addr_pad = ceil(log2(depth)/4);
data_pad = ceil(width/4);

%% Write prefix header to file
file = fopen(filename, 'w');
fprintf(file, '-- file: %s\r\n', filename);

%% Comments
if(nargin == 5)
    fprintf(file, '%%\r\n%s%%\r\n\r\n', comments);
end

%% Data Type headers
fprintf(file, 'WIDTH=%i;\r\n'  , width);
fprintf(file, 'DEPTH=%i;\r\n\r\n', depth);

fprintf(file, 'ADDRESS_RADIX=HEX;\r\n');
fprintf(file, 'DATA_RADIX=HEX;\r\n\r\n');

%% Write data payload to file
fprintf(file, 'CONTENT\r\nBEGIN\r\n');
for i = 1:min(length(data_vec), depth)
    fprintf(file, '%0*X : %0*X;\r\n',          ...
        addr_pad,  i-1,                       ...
        data_pad, data_vec(i)               ...
        );
end
if length(data_vec) < depth
    fprintf(file, '[%0*X..%0*X] : %X;\r\n',    ...
        addr_pad, i,                      ...
        addr_pad, depth-1,                  ...
        hex2dec(repmat('0', 1, data_pad))   ...
        );
end

%% Finish Write
fprintf(file, 'END');
fclose(file);

end


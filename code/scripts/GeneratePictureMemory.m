%% Create data memory
clear; format short;

%% Data constants
mif_file = "p_mem.mif";
load('ColorMap');
pmem_depth = 2^19;
pmem_width = 2;

%% Get all card image names
suits = {'c','d', 'h', 's'};
ranks = {'a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k'};

card_names = cell(1, length(suits) * length(ranks));

i = 0;
for suit = suits
    for rank = ranks
        i = i + 1;
        card_names{i} = sprintf('%s-%s', suit{1}, rank{1});
    end
end

%% Get dice as well
dice = {'1', '2', '3', '4', '5', '6'};
dice_names = cell(1, length(dice));

for i = 1:length(dice)
    dice_names{i} = sprintf('dice-%s', dice{i});
end

%% Iterate across images
image_files = [card_names, dice_names];
num_files = length(image_files);
vecs = cell(1, length(num_files));

comment = '';
address = 0;

for i = 1:num_files
    curr_file = sprintf('%s.png', image_files{i});
    [image_vec, rows, cols] = makeImageDataVector(curr_file, colorToIndexMap);
    vecs{i} = image_vec;
        
    comment = sprintf('%s\t%-8s | <w: %3i, h: %3i> | addr: %6i\r\n', ...
        comment, image_files{i}, cols, rows, address);
    
    address = address + length(image_vec);
end

%% Concatenate image vectors
mem_vec = zeros(address+1, 1, 'uint8');
address = 1;
for i = 1:num_files
    image_vec = vecs{i};
    next_address = address + length(image_vec);
    mem_vec(address:next_address-1) = image_vec;
    address = next_address;
end

%% Write to file
writeMif(mif_file, mem_vec, pmem_depth, pmem_width, comment);

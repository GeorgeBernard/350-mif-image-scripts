%% Generate Mif file
clear; format short;

%% Data Constants
load('ColorMap')

%% Make Color Mapping MIF file
color_depth = 4;
color_width = 24;
color_filename = 'c_mem.mif';
color_keys = cell2mat(keys(colorToIndexMap));

writeMif(color_filename, color_keys, color_depth, color_width);

%% Generate the formatted splash screen

GenerateFormatImageIndex;

%% Generate picture memory

GeneratePictureMemory;

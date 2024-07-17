%%%% Example
%%%% Enter settings here
% The given paths cannot rely on tilde expansion
membranePath = './../../mdata/ffn/4-ffn-black/prob-vast-membrane/';
mip = 0; %%% membranes wil be read at this mip level
sections = [0:99:1]; % sections to run on
outFolder = './../../mdata/ffn/4-ffn-black/2d-instance-seg';
reduce = 0.05;
crop = 0;
ds = 1; % downscale factor

size_x = 512;
size_y = 512;
size_z = 100;
voxelsizex = 3;
voxelsizey = 3;
voxelsizez = 30;

% Generates 2D segmentation stack
sectionTime = tic;
compute2dsegs({membranePath}, mip, sections, outFolder, reduce, crop, ds);
sectionTime_elapsed = toc(sectionTime)

% Generates a corresponding VSVI file for the stack
new_file = fopen(fullfile(outFolder, "2d-instance-seg.vsvi"), "w");
vsvi_lines = readlines("vsvi_template.txt");
for line_idx = 1:length(vsvi_lines)
    line = vsvi_lines(line_idx);
    new_line = strrep(line, "PATH", outFolder);
    new_line = strrep(new_line, "TRGDATAX", num2str(size_x));
    new_line = strrep(new_line, "TRGDATAY", num2str(size_y));
    new_line = strrep(new_line, "TRGDATAZ", num2str(size_z));
    new_line = strrep(new_line, "VXSIZEX", num2str(voxelsizex));
    new_line = strrep(new_line, "VXSIZEY", num2str(voxelsizey));
    new_line = strrep(new_line, "VXSIZEZ", num2str(voxelsizez));
    fprintf(new_file, "%s\n", new_line);
end
fclose(new_file);

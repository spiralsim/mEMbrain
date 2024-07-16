%%%% Example
membranePath = './../../mdata/ffn/4-ffn-black/prob-vast-membrane/';
mip = 0; %%% membranes wil be read at this mip level
sections = [0:99:1]; % sections to run on
outFolder = '2d-instance-seg';
reduce = 0.05;
crop = 0;
ds = 1;

sectionTime = tic;
compute2dsegs({membranePath}, mip, sections, outFolder, reduce, crop, ds);
sectionTime_elapsed = toc(sectionTime)

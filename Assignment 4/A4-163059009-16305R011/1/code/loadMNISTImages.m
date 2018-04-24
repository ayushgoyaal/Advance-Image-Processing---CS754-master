function [images,labels] = readMnistDS(imgFilename,labelFilename)

    %Init
    images=readImageDS(imgFilename);
    labels=readLabelDS(labelFilename);

    % Reshape to #pixels x #examples
    %images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
    % Convert to double and rescale to [0,1]
    %images = double(images) / 255;

end

% Read image dataset
function images=readImageDS(filename)
    fp = fopen(filename, 'rb');
    assert(fp ~= -1, ['Could not open ', filename, '']);
    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    %assert(magic == 2051, ['Bad magic number in ', filename, '']);
    numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
    numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
    numCols = fread(fp, 1, 'int32', 0, 'ieee-be');
    images = fread(fp, inf, 'unsigned char');
    images = reshape(images, numCols, numRows, numImages);
    images = permute(images,[2 1 3]);
    fclose(fp);
end
% Read image label dataset
function labels=readLabelDS(filename)
    fp = fopen(filename, 'rb');
    assert(fp ~= -1, ['Could not open ', filename, '']);
    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    %assert(magic == 2049, ['Bad magic number in ', filename, '']);    
    numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
    labels = fread(fp, inf, 'unsigned char');
    fclose(fp);
end
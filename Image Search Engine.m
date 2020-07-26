% initialising the source files' directory and type of files (jpg)
srcfile = dir('C:\Users\Luqman\Desktop\Level 1\Dataset\*.jpg');
% finding the feature vector of the query image from the 'fveccal' function
% the 'fveccal' function takes a number which corresponds to the number of
% the image in the dataset. This has been done for easier evaluation to
% avoid manual importing of the dataset and naming the image manually as
% well. Just varying the number here will be enough to vary the query
% image. '1' is given as a sample.
queryfvec = fveccal(1);
% 'imresults' is the matrix where the 'sum' values of the images that
% satisfy the threshold value are stored ('sum' is where the sum of all the
% elements of the chisquared vector is stored).
imresults = [];
% 'allimresults' is the matrix where all the 'sum' values of the images are
% stored irrespective of satisfying the threshold value or not. This will
% be useful as explained later.
allimresults = [];
% we are finding the number of images in the dataset directory and storing
% in the variable 'num' so as to give an upper limit to the for loops
a=dir(['C:\Users\Luqman\Desktop\Level 1\Dataset\*.jpg']);
num=size(a, 1);
% in this loop, we are finding the images that satisfy the threshold value
% as well as the 'imresults' and 'allimresults' as explained above
for i = 1:num
        imfvec = fveccal(i);
        % 'calc' function to find the sum of the elements of the chisquared
        % matrix which takes the feature vectors of the query image and the
        % image to which we are comparing as the function parameters
        sum = calc(queryfvec, imfvec);
        % 1.4 is the threshold value and sum>0 is included to avoid the input image in the output
        % see end of code to know more how the threshold value was found
    if (sum<0.680 && sum>0)
        imresults = [imresults, sum];
    end
    allimresults = [allimresults, sum];        
end
% this if condition ensures that the images with no matching image within
% the threshold value still has atleast one output. We use the 'allimresults'
% matrix since the 'imresults' matrix would be empty as there were no
% matching images within the threshold value.
% 'topimresults' sorts out one of the matrices in the above loop as
% applicable in ascending order so as to keep the most similiar images at
% the top.
if (length(imresults)==0)
    topimresults = sort(allimresults);
    % 'k' value to find upper value of the the next for loop where the output will be obtained.
    % it is 2 in this case since the first element will be skipped anyways
    % in the next loop, hence giving only one output and also since because
    % the 'allimresults' matrix which we are sorting includes the query image itself.
    k = 2;
else
    topimresults = sort(imresults);
    % top 3 images being taken
    % we need the minimum value of k so as to not print junk values if
    % there is no third matching image in the threshold value. Also, we
    % havent incremented the value by 1 as in the above k value since the
    % 'imresults' matrix which we are sorting does not include the query
    % image itself.
    k = min(length(topimresults), 3);
end
% two for loops to display the most similiar images in order    
for j = 1:k
    for m = 1:num
        imfvec = fveccal(m);
        sum = calc(queryfvec, imfvec);
        filename = strcat('C:\Users\Luqman\Desktop\Level 1\Dataset\', srcfile(m).name);
        I = imread(filename);
        if(sum==topimresults(j) && sum>0)
            figure, imshow(I); % results being displayed
        end
    end
end
% function to find feature vector
function imagefvec = fveccal (n)
        srcfile = dir('C:\Users\Luqman\Desktop\Level 1\Dataset\*.jpg');
        filename = strcat('C:\Users\Luqman\Desktop\Level 1\Dataset\', srcfile(n).name);
        I = imread(filename);
        Red = I(:,:,1);
        Green = I(:,:,2);
        Blue = I(:,:,3);
        % the feature vector is a concatenation of the RGB vectors
        imagefvec = [imhist(Red); imhist(Green); imhist(Blue)];
end
% applying chisquared method for quantifying similiarity between the
% query image and dataset's image.
% function to find the sum of the elements of the chisquared matrix which
% will be used as the threshold variable.
function sumchisq = calc (inputfv, imagefv)
        chisq = (((inputfv)-(imagefv)).^2) ./ (inputfv + imagefv);
        chisq(isnan(chisq) | isinf(chisq)) = 0;
        sumchisq = sum(chisq) ./100000;
end
% threshold value was picked by the following method:
% - found average 'sum' value for each image by running two for loops (not in code here) and
% comparing the images only within the subset folder it belonged to
% - then again found average of the 'sum' values with respect to the
% entire subset folder (stored in a 'S' variable)
% - then found the average of the 'S' variable by adding the four 'S'
% variables of the subfolders and dividing by 4
% - tweaked further more around this value by finding minimum and maximum
% 'sum' values of each particular different type of image (dark, light, colourful, etc.)
% within the subset values to finally obtain the threshold value
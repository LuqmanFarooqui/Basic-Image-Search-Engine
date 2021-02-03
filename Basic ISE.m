srcfile = dir('Dataset\*.jpg');
queryfvec = fveccal(1);
imresults = [];
allimresults = [];
a=dir(['Dataset\*.jpg']);
num=size(a, 1);
for i = 1:num
        imfvec = fveccal(i);
        sum = calc(queryfvec, imfvec);
    if (sum<0.680 && sum>0)
        imresults = [imresults, sum];
    end
    allimresults = [allimresults, sum];        
end
if (length(imresults)==0)
    topimresults = sort(allimresults);
    k = 2;
else
    topimresults = sort(imresults);
    k = min(length(topimresults), 3);
end
for j = 1:k
    for m = 1:num
        imfvec = fveccal(m);
        sum = calc(queryfvec, imfvec);
        filename = strcat('Dataset\', srcfile(m).name);
        I = imread(filename);
        if(sum==topimresults(j) && sum>0)
            figure, imshow(I);
        end
    end
end
% function to find feature vector
function imagefvec = fveccal (n)
        srcfile = dir('Dataset\*.jpg');
        filename = strcat('Dataset\', srcfile(n).name);
        I = imread(filename);
        Red = I(:,:,1);
        Green = I(:,:,2);
        Blue = I(:,:,3);
        imagefvec = [imhist(Red); imhist(Green); imhist(Blue)];
end
function sumchisq = calc (inputfv, imagefv)
        chisq = (((inputfv)-(imagefv)).^2) ./ (inputfv + imagefv);
        chisq(isnan(chisq) | isinf(chisq)) = 0;
        sumchisq = sum(chisq) ./100000;
end

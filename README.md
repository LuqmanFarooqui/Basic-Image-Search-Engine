# Basic Image Search Engine
This MATLAB code is the implementation of a basic image search engine.

### Instructions

- The code assumes you to have a folder named "Dataset" which is the folder within which you want to search. Alternatively, you can enter your folder's file path manually.
- The code assumes that the image you want to search similiar images for in the dataset, is the first image in the dataset itself. Hence, have your query image's file name such that it is the first in the dataset, or you can adjust which image to be taken in the 2nd line of code. Alternatively, you can provide the location of the image manually by entering it in a variable.

### Demo images

Demo input:

<img src="demo_pics/ip.jpg" alt="Demo input" width="400" height="166"/>

Images in order of decreasing similarity:

<img src="demo_pics/op1.jpg" alt="Output 1" width="400" height="166"/>


<img src="demo_pics/op2.jpg" alt="Output 2" width="400" height="166"/>


<img src="demo_pics/op3.jpg" alt="Output 3" width="400" height="166"/>


### Notes

- The threshold value has been set to 0.680. You may change it and see which value gives you better results - let me know in the comments section !
- You will see a maximum of top 3 image results, or less, if at all 3 images satisfy the threshold value. The order is in decreasing similarity.

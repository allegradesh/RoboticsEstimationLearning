% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
% 
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 

%figure;
%imshow(I)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
% mu = [mean_H,mean_S,mean_V]
% sig =[var_H cov_HS cov_HV; cov_HS var_S cov_SV; cov_HV cov_SV var_V] 
% thre =        % threshold
load mu.mat;
load sig.mat
thre = 0.01;   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
I_hsv = rgb2hsv(I);
% search ever 4*4
I_hsv =  reshape(I_hsv,[size(I,1)*size(I,2),3]);
I_hsv_minus_mu = I_hsv - repmat(mu,size(I,1)*size(I,2),1);
p = exp(-0.5*sum(I_hsv_minus_mu*inv(sig).*I_hsv_minus_mu,2))/((2*pi)^1.5*(det(sig))^0.5);

bw = reshape(p,[size(I,1),size(I,2),1])> thre; 
%figure, imshow(bw); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.
% create new empty binary image
bw_biggest = false(size(bw));

% http://www.mathworks.com/help/images/ref/bwconncomp.html
CC = bwconncomp(bw);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
bw_biggest(CC.PixelIdxList{idx}) = true; 
%figure,
%imshow(bw_biggest); hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%
S = regionprops(CC,'Centroid');
loc = S(idx).Centroid;
%plot(loc(1), loc(2),'r+');
segI = bw_biggest;

% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end


% Robotics: Estimation and Learning 
% WEEK 3
% 
% This is an example code for collecting ball sample colors using roipoly
close all

imagepath = './train';
Samples = [];
for k=1:19
    % Load image
    I = imread(sprintf('%s/%03d.png',imagepath,k));
    I_hsv = rgb2hsv(I);
    % You may consider other color space than RGB
    %R = I(:,:,1);
    %G = I(:,:,2);
    %B = I(:,:,3);
    H = I_hsv(:,:,1);
    S = I_hsv(:,:,2);
    V = I_hsv(:,:,3);    
    %figure(10),imhist(uint8(H*255));
    
    % Collect samples 
    disp('');
    disp('INTRUCTION: Click along the boundary of the ball. Double-click when you get back to the initial point.')
    disp('INTRUCTION: You can maximize the window size of the figure for precise clicks.')
    figure(1), 
    mask = roipoly(I); 
    figure(2), imshow(mask); title('Mask');
    sample_ind = find(mask > 0);
    
    %R = R(sample_ind);
    %G = G(sample_ind);
    %B = B(sample_ind);
    H = H(sample_ind);
    S = S(sample_ind);
    V = V(sample_ind);    
    
    %Samples = [Samples; [R G B]];
    Samples = [Samples; [H S V]];
    
    disp('INTRUCTION: Press any key to continue. (Ctrl+c to exit)')
    pause
end

% visualize the sample distribution
figure, 
scatter3(Samples(:,1),Samples(:,2),Samples(:,3),'.');
title('Pixel Color Distribubtion');
%xlabel('Red');
%ylabel('Green');
%zlabel('Blue');
xlabel('Hue');
ylabel('Saturation');
zlabel('Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [IMPORTANT]
%
% Now choose you model type and estimate the parameters (mu and Sigma) from
% the sample data.
%


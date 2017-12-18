close all;
image=imread('test\3.jpg');
figure(1);
imshow(image);
imgray=rgb2gray(image); 
[m,n]=size(imgray);

% Conversion to binary and thresholding

for i=1:m
    for j=1:n
        if imgray(i,j)<127
            imgray(i,j)=0;
        else
            imgray(i,j)=255;
        end
    end
end

figure(2);
imshow(imgray);

%Image opening to fill white crevices

se=strel('square',15);
imgray=imopen(imgray,se);
figure(3);
imshow(imgray);

% gauss_fil = fspecial('gaussian');
% imgray1=imfilter(im2double(imgray),gauss_fil);
%[imgray]=edgeGradient(imgray);

imgray=edge(imgray,'canny',[],3);
figure(4);
imshow(imgray);
houghtrans(imgray,image);

% % Corner Detection
% sum_array=[];
% index_array_x=[];
% index_array_y=[];
% diff_array=[];
% 
% for i=1:m
%     for j=1:n
%         if imgray(i,j)>0
%             sum_array=[sum_array,i+j];
%             index_array_x=[index_array_x,i];
%             index_array_y=[index_array_y,j];
%             diff_array=[diff_array,i-j];
%             
%   
%         end
%     end
% end
% 
% k=length(sum_array);
% max1=max(sum_array);
% min1=min(sum_array);
% 
% max2=max(diff_array);
% min2=min(diff_array);
% 
% for i=1:k
%     if sum_array(i)== max1
%         bottom_right_x=index_array_y(i);
%         bottom_right_y=index_array_x(i);
%     elseif sum_array(i)== min1
%          top_left_x=index_array_y(i);
%          top_left_y=index_array_x(i);
%     end
%     
%    if diff_array(i)== min2
%         top_right_x=index_array_y(i);
%         top_right_y=index_array_x(i);
%    elseif diff_array(i)== max2
%          bottom_left_x=index_array_y(i);
%          bottom_left_y=index_array_x(i);
%    end
% end
%         
% 
% % Find out whether point of impact is within the pc screen or not, i.e.
% % Check if target was hit.If yes go for mapping
% 
% central_x=n/2;
% central_y=m/2;
% ymax=max(max(bottom_left_y,top_left_y),max(top_right_y,bottom_right_y));
% ymin=min(min(bottom_left_y,top_left_y),min(top_right_y,bottom_right_y));
% xmax=max(max(bottom_left_x,bottom_right_x),max(top_left_x,top_right_x));
% xmin=min(min(bottom_left_x,bottom_right_x),min(top_left_x,top_right_x));
% if xmin < central_x && central_x < xmax &&  ymin < central_y && central_y < ymax 
%     % Begin mapping.....
%     pt=[central_x,central_y,0];
%     tr=[top_right_x,top_right_y,0];
%     tl=[top_left_x,top_left_y,0];
%     br=[bottom_right_x,bottom_right_y,0];
%     bl=[bottom_left_x,bottom_left_y,0];
%     
%     %% Find outperpendicular distance between central pixe and all te sides of quadrilateral
%     d1=norm(cross((tr-tl),(pt-tr)))/norm(pt-tl);
%     d2=norm(cross((br-bl),(pt-br)))/norm(pt-bl);
%     d3=norm(cross((tl-bl),(pt-bl)))/norm(pt-tl);
%     d4=norm(cross((tr-br),(pt-tr)))/norm(pt-tr);
%     %% As per definition of our transform.. ratio of perpendicular distance before and after transformatio must remain same.
%     %% Using this we calculate values of mapped x and y co ordinates.
%     
%     ymapped=100*d1/(d1+d2);
%     xmapped=100*d3/(d3+d4);
%     print ymapped
%     print xmapped
% else
%     print 'miss'
% end
% 
% %% Here ymapped and xmapped are calculated with respect to resolution (100,100) for a general resolution (a,b)
% %% xmapped and ymapped can be calculated as xmapped=(a/100)*xmapped,ymapped=(b/100)*ymapped
% %%This transform is a scalable transform
% 
% xmapped
% ymapped

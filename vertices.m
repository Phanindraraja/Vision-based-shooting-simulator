function vertices(s,image)
resx=1920;
resy=1080;
x=zeros(2,2);
y=zeros(2,2);
k=0;
[a,b,~]=size(image);
for i=1:4
    for j=i+1:4
        xx=s(:,:,i);
        yy=s(:,:,j);
        x(:,1)=xx(:,1);
        x(:,2)=yy(:,1);
        y(:,1)=xx(:,2);
        y(:,2)=yy(:,2);
        % Take the differences down each column
        dx = diff(x);
        dy = diff(y);
        % Calculate the denominator
        den = dx(1)*dy(2)-dy(1)*dx(2);
        z = (dx(2)*(y(1)-y(3))-dy(2)*(x(1)-x(3)))/den;
        vx = x(1)+z*dx(1);
        vy = y(1)+z*dy(1);
        if (vx>=0&&vx<b&&vy>=0&&vy<a)
            k=k+1;
%             ver(:,:,k)=[vx,vy];
            ver(:,:,k)=[vy,vx];
            
            
        end
    end
end

xmin=min(ver(1,1,:));
xmax=max(ver(1,1,:));
ymin=min(ver(1,2,:));
ymax=max(ver(1,2,:));

%%%%%%%%%%%%%%%%%%%%%%%Mapping

sum_array=[];
index_array_x=[];
% index_array_y=[];
diff_array=[];
for i=1:4
    
   sum_array=[sum_array,ver(1,1,i)+ver(1,2,i)];
   index_array_x=[index_array_x,i];
   diff_array=[diff_array,ver(1,1,i)-ver(1,2,i)];
end
    


k=length(sum_array);
max1=max(sum_array);
min1=min(sum_array);

max2=max(diff_array);
min2=min(diff_array);

for i=1:4
    if sum_array(i)== max1
        bottom_right_x=ver(1,1,i);
        bottom_right_y=ver(1,2,i);
    elseif sum_array(i)== min1
         top_left_x=ver(1,1,i);
         top_left_y=ver(1,2,i);
    end
    
   if diff_array(i)== min2
        top_right_x=ver(1,1,i);
        top_right_y=ver(1,2,i);
   elseif diff_array(i)== max2
         bottom_left_x=ver(1,1,i);
         bottom_left_y=ver(1,2,i);
   end
end

central_x=a/2;
central_y=b/2;

if xmin < central_x && central_x < xmax &&  ymin < central_y && central_y < ymax 
    % Begin mapping.....
    pt=[central_x,central_y,0];
    tr=[top_right_x,top_right_y,0];
    tl=[top_left_x,top_left_y,0];
    br=[bottom_right_x,bottom_right_y,0];
    bl=[bottom_left_x,bottom_left_y,0];
    
    %% Find outperpendicular distance between central pixe and all te sides of quadrilateral
    d1=norm(cross((tr-tl),(pt-tr)))/norm(pt-tl);
    d2=norm(cross((br-bl),(pt-br)))/norm(pt-bl);
    d3=norm(cross((tl-bl),(pt-bl)))/norm(pt-tl);
    d4=norm(cross((tr-br),(pt-tr)))/norm(pt-tr);
    %% As per definition of our transform.. ratio of perpendicular distance before and after transformatio must remain same.
    %% Using this we calculate values of mapped x and y co ordinates.
    
    ymapped=100*d1/(d1+d2);
    xmapped=100*d3/(d3+d4);
    disp(ymapped);
    disp(xmapped);
else
    %central pixel outside
    disp('miss');
end
    xmapped=xmapped*resx/100
    ymapped=ymapped*resy/100
%disp(ver); 
   theta = linspace(0, 2*pi, 50).';
   R=0.5:50:700;
   figure(10);
   plot(resx/2+cos(theta)*R, resy/2+sin(theta)*R);
   hold on;
   plot(xmapped,ymapped, '-gs', 'MarkerSize',10,'MarkerFaceColor','green');
   axis([0 resx  0 resy])
   hold off;
%disp(ver);

   
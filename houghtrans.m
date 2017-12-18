function houghtrans(I,image)
%I  = rgb2gray(imread('C:\Users\Phanindra\Desktop\CV project\Resized\18.jpg'));
[H,theta,rho] = hough(I);
figure(5);
imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(I,theta,rho,P,'FillGap',5,'MinLength',7);
%figure, imshow(I), hold on
v=0;
figure(6);
imshow(image);
hold on;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','green');

   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if (len > 45)
      v=v+1;
      xy_long = xy;
      s(:,:,v)=[lines(k).point1;lines(k).point2];
      %disp(lines(k).point1);
      %disp(lines(k).point2);
      plot(xy_long(:,1),xy_long(:,2),'LineWidth',5,'Color','green');
   end
end
disp(s);
vertices(s,image);
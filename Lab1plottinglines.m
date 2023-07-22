clc
clear all
format short
%How to draw linea in matlab
%-x1+3x2=10
%x1+x2=6
%x1-x2=2
%Phase 1: To input parameters
A = [-1 3;1 1; 1 -1]
B = [10;6;2];
%Phase 2: To plot the lines on graph
y1 = 0:max(B)
x11 = (B(1) - A(1,1).*y1)./A(1,2);
x21 = (B(2) - A(2,1).*y1)./A(2,2);
x31 = (B(3) - A(3,1).*y1)./A(3,2);
x11 = max(0,x11)
x21 = max(0,x21)
x31 = max(0,x31)
plot(y1,x11,'r', y1, x21,'b', y1, x31, 'g')
title('Plots for given lines')
xlabel('X1')
ylabel('Y1')
legend('-x1+3x2=10','x1+x2=6','x1-x2=2')
grid on
%Phase 3: To find corner point with axis
cx1 = find(y1==0) %points with x1 axis
c1 = find(x11==0) %points with x2 axis
line1 = [y1(:,[c1 cx1])]; x11(:,[c1 cx1])'

c2 = find(x21==0) %points with x2 axis
line2 = y1(:,[c2 cx1]); x21(:,[c2 cx1])'

c3 = find(x31==0) %points with x2 axis
line3 = y1(:,[c3 cx1]); x21(:,[c3 cx1])'

corpt = unique([line1;line2;line3], 'rows')
clc
clear all
format short

% 2x1+4x2=12
% x1-x2=10
% 2x1+x2=8

%Phase I: To input Parameter

A=[-1 3; 1 1; 1 -1];
B=[10; 6; 2];

%Phage II: To Plot the lines on the graph

y1= 0:max (B);
x11= (B(1)-A(1,1).*y1)./A(1,2);
x21= (B(2)-A(2,1).*y1)./A(2,2);
x31= (B(3)-A(3,1).*y1)./A(3,2);

x11=max(0,x11)
x21=max(0,x21)
x31=max(0,x31)

plot (y1, x11, 'r',y1,x21,'b',y1, x31,'g')

title('xl vs x2')
xlabel ('value of x11');
ylabel ('value of x21');
legend('2x1+4x2=12','x1-x2=10','2x1+x2=8');
grid on

%Phase 3

cx1 = find(y1==0)
c1 = find(x11==0)
line1 = [y1(:,[c1 cx1]); x11(:,[c1 cx1]);]';

c2 = find(x21==0)
line2 = [y1(:,[c2 cx1]); x21(:,[c2 cx1]);]';

c3 = find(x31==0)
line3 = [y1(:,[c3 cx1]); x31(:,[c3 cx1]);]';

corpt = unique([line1;line2;line3],'rows')

%phase 4

pt = [0;0]

for i=1:size(A,1)
    A1 = A(i,:)
    B1 = B(i,:)
    for j=i+1:size(A,1)
        A2 = A(j,:);
        B2 = B(j,:);
        A4 = [A1;A2];
        B4 = [B1;B2];
        X = A4\B4;
        pt = [pt X]
    end
end 

ptt = pt'

%phase 5 

allpt = [ptt;corpt];
points = unique(allpt,"rows")

%phase 6
%find the feasible region 

PT = feasible_reg(points)
P = unique(PT,"rows")

%phase 7 : find value of objective func
%max z = x1+5x2

c = [1 5]

for i=1:size(P,1)
    fn(i,:)= (sum(P(i,:).*c))
end

values = [P fn]

%phase 8 : to find optimal sol
[Optval Optposition] = max(fn)
Optval = values(Optposition,:)
OPTIMAL_BFS = array2table(Optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(Optval,2))={'x1','x2','z'}
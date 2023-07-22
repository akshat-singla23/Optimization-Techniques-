clc
clear all
format short
%Matlab code for least cost to find initial BFS
%Input phase
Cost=[11 20 7 8 ;21 16 10 12; 8 12 18 9]
A=[50 40 70]
B=[30 25 35 40]
%To check the tp is balanced or not?
if sum(A)==sum(B)
    fprintf("The given tp is balanced")
else
    fprintf("given tp is not balanced")
    if sum(A)<sum(B)
        Cost(end+1,:)=zeros(2,size(B,2))
        A(end+1)=sum(B)-sum(A)
    elseif sum(B)<sum(A)
        Cost(:,end+1)=zeros(1,size(A,2))
        B(end+1)=sum(A)-sum(B)
    end
end
ICost=Cost
[m,n] = size(Cost)
bfs = n+m-1
x = zeros(size(Cost))
for i = 1:size(Cost,1)
   for j = 1:size(Cost,2)
    hh = min(Cost(:))
    [row_index,col_index] = find(hh == Cost)
    x11 = [min(A(row_index), B(col_index))]
    [value, index] = max(x11)
    i = row_index(index)
    j = col_index(index)
    y11 = min(A(i),B(j))
    x(i,j) = y11
    A(j) = A(i)-y11
    B(j) = B(i)-y11
    Cost(i,j) = inf
    end
end
fprintf("Initial BFS")
IBFS = array2table(x);
disp(IBFS)
% To check degerenracy
TotalBFS = length(nonzeros(x))
if TotalBFS == bfs
    fprintf("The solution is non degenerate")
else
    fprintf("The solution is degenerate")
end
initialcost = sum(sum(ICost.*x))

% To find the basic feasable solutions
% max z = x1 + 2x2
% Subject to 
% − x1 + x2 ≤ 1
%  x1 + x2 ≤ 2
% x1,x2>=0
clc
clear all
format short
% Phase 1: Input parameters
A = [-1 1;1 1]
C = [1 1]
b = [1; 2]
% Phase 2: To define number of variables and constraints
n = size(A,2)
m = size(A,1)
% Phase 3: To choose nCm basic solutions
if(n>m)
nCm = nchoosek(n,m)
pair = nchoosek(1:n,m)

% Phase 4 & 5: To construct basis and to find basic feasable solutions
sol = []
for i = 1:nCm 
    y = zeros(n,1)
    x = A(:, pair(i,:))\b
    if all(x>=0 & x~=inf & x~=-inf)
        y(pair(i,:))=x
        sol = [sol, y]
    end
end
else
    error('nCm does not exist')
end
% Phase 6: To find the objective function Value
z = C*sol
% To FInd the Optimal Value 
[zmax, zindex] = max(z)
BFS = sol(:,zindex)
% To Print all the solutions 
optimal_value = [BFS', zmax]
optimal_bfs = array2table(optimal_value)
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2)) = {'x1', 'x2','x3', 'x4', 'z'}
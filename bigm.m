clc
clear all
format short
variables={'x1','x2','s1','s2','s3','A1','A2','A3','sol'};
M = 1000;
cost = [-12 -10 0 0 0 -M -M -M 0];
A = [5 1 -1 0 0 1 0 0 10; 6 5 0 -1 0 0 1 0 30; 1 4 0 0 -1 0 0 1 8]
s = eye(size(A,1));
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i) == s(:,j)
            BV = [BV i];
        end
    end
end
zjcj = cost(BV)*A -cost
%print table
zcj = [zjcj;A];
Simptable = array2table(zcj);
Simptable.Properties.VariableNames(1:size(zcj,2))= variables
%Finding entering variable
Run=true
while Run
zc = zjcj(:,1:end-1);
if any (zc<0)
    fprintf("The current BFS not optimal\n");
    [EnterCol,Pvt_Col]=min(zc)
    fprintf('Entering Column is %d\n',Pvt_Col)
%To find the leaving Variable
sol=A(:,end)
Column=A(:,Pvt_Col)
if all (Column<=0)
    fprintf("Solution is unbounded")
else
     for i=1:size(Column,1)
         if Column(i)>0
            ratio(i)=sol(i)./Column(i);
        else
            ratio(i)=inf;
        end
    end
    [MinRatio, Pvt_Row]=min(ratio);
    fprintf('Leaving row is %d \n',Pvt_Row);
end
BV(Pvt_Row)=Pvt_Col
disp('New Basic Variable (BV) =')
disp(BV)
Pvt_Key=A(Pvt_Row,Pvt_Col)
%update table for next iteration
A(Pvt_Row,:)=A(Pvt_Row,:)./Pvt_Key
for i=1:size(A,1)
    if i~=Pvt_Row
        A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:)
    end
end
zjcj = cost(BV)*A -cost
zcj = [zjcj;A];
Table = array2table(zcj);
Table.Properties.VariableNames(1:size(zcj,2)) = variables
else
    Run = false;
    fprintf('The current BFS is optimal')
end
end
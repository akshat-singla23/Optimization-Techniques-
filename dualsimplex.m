clc 
clear all
format short
Variables={'x1','x2','s1','s2','sol'};
Cost=[-3 -5 0 0 0];
info=[-1 -3 ;-1 -1 ];
s = eye(size(info,1))
b=[-3; -2];
A = [info s b]
BV = [];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV = [BV i];
        end
    end
end
fprintf('Basic Variables (BV)=')
disp(Variables(BV));
ZjCj = Cost(BV)*A-Cost;
ZCj = [ZjCj;A];
Simptable = array2table(ZCj);
Simptable.Properties.VariableNames(1:size(ZCj,2)) = Variables
RUN = true;
while RUN
sol = A(:,end);
if any(sol<0)
    fprintf("Current BFS is not feasible \n");
%Finding the leaving variable 
    [LV, pivot_row] = min(sol);
    fprintf("Leaving row =%d\n",pivot_row);
 %finding entering variable 
 Row = A(pivot_row,1:end-1);
 ZJ = ZjCj(:,1:end-1);
 for i=1:size(Row,2)
     if Row(i)<0
         ratio(i)= abs(ZJ(i)./Row(i));
     else
         ratio(i)=inf;
     end
 end
 [minVal, pvt_col]=min(ratio);
 fprintf("Entering Variable = %d\n",pvt_col);
 
 %Updation
 BV(pivot_row)=pvt_col;
 fprintf('Basic Variables (BV) =')
 disp(Variables(BV));
 
 pvt_key = A(pivot_row,pvt_col);
 A(pivot_row,:)=A(pivot_row,:)./pvt_key;
 
 for i=1:size(A,1)
     if i~=pivot_row
         A(i,:)=A(i,:)-A(i,pvt_col).*A(pivot_row,:);
     end
 end
 ZjCj = Cost(BV)*A-Cost
 
else
    RUN = false
    fprintf("Current BFS is feasible");
    ZCj = [ZjCj;A];
    SimpTable= array2table(ZCj);
    SimpTable.Properties.VariableNames(1:size(ZCj,2)) = Variables
end
end
solution=ZCj(1,end);
fprintf('\noptimal solution reached');
fprintf('\n\n optimal solution is %d',-1*solution)
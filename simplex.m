%Program of Simplex Method
%Min z=x1-3x2+2x3
%Subject to 3x1-x2+2x3<=7
%-2x1+4x2<=12
%-4x1+3x2+8x3<=10
%x1,x2,x3>=0
%Max z= -x1+3x2-2x3

clc
clear all
format short

%To input parameters 
info = [3 -1 2;-2 4 0;-4 3 8]
C= [-1 3 -2]
b = [7;12;10]

% Phase 2: To define number of variables and constraints
NOVariables=size(info,2); %2 for columns
s=eye(size(info,1)); %1 for rows of info
A=[info s b];

%The simplex body matrix
Cost=zeros(1,size(A,2));
Cost(1:NOVariables)=C;

%to define basic variables
BV=NOVariables+1:size(A,2)-1 ; %These are the positions

% To calculate row
Zrow = Cost(BV)*A-Cost

%To print the table
ZjCj = [Zrow;A]
SimpTable = array2table(ZjCj)
SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x1','x2','x3','s1','s2','s3','Sol'}

%Simplex Method starts
Run=true
while Run
ZC = Zrow(1:end-1)
if any(ZC<0)
    fprintf('The current BFS is not optimal \n')
    fprintf('\n=========The next iteration result====== \n')
    disp('Old Bsic variable(BV)=')
    disp(BV)

    %To find entering variable
    [EnterCol,Pvt_Col]=min(ZC)
    fprintf('The most negative element in Zrow is %d corresponding to column %d\n',EnterCol,Pvt_Col)
    fprintf('Entering variable is %d \n',Pvt_Col)

    %To find leaving variable
    sol=A(:,end)
    Column=A(:,Pvt_Col)
    if all(Column<=0)
        error('LPP has unbounded solution')
    else
        for i=1:size(Column,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i)
            else
                ratio(i)=inf
            end
        end
    
        %To find minimun ratio
        [MinRatio, Pvt_Row]=min(ratio)
        fprintf('Minimum ratio corresponding to pivot row is %d \n',Pvt_Row)
        fprintf('Leaving Variable is %d \n',BV(Pvt_Row))  
    end
    BV(Pvt_Row)=Pvt_Col
    disp('New Basic Variable (BV) =')
    disp(BV)

    % To identify pvt element
    pvt_key = A(Pvt_Row, Pvt_Col)

    % Update table for next iteration
    A(Pvt_Row,:) = A(Pvt_Row,:)./pvt_key
    for i=1:size(A,1)
        if(i~=Pvt_Row)
            A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:)
        end
        Zrow = Zrow - Zrow(Pvt_Col).*A(Pvt_Row,:)
        
        %to print the updated table
        ZjCj=[Zrow;A]
        SimpTable=array2table(ZjCj)
        SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x1','x2','x3','s1','s2','s3','sol'}
        
        bfs = zeros(1,size(A,2))
        bfs(BV) = A(:, end)
        bfs(end) = sum(bfs.*Cost)

        currentbfs = array2table(bfs)
        currentbfs.Properties.VariableNames(1:size(currentbfs,2))={'x1','x2','x3','s1','s2','s3','sol'}

    end
    
    end
end
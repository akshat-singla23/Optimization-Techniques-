function [bfs,A] = simp_func(A,bv,cost,Variables)
format rational
bfs = 0
run = true
zjcj = (cost(bv)*A) - cost
while run
    zc = zjcj(1:end-1)
    if any(zc<0)
        fprintf('The current BFS is not Optimal \n')
        fprintf('\n Next iteration continues \n ')
        fprintf('Old basic variable (bv) = \n ')
        disp(bv)
        zc = zjcj(1:end-1)
        [enter_col,pvt_col]=min(zc)
        fprintf('THE MOST NEGATIVE ELEMENT IN Z-ROW IS %d CORRESPONDING TO COLUMN %d \n',enter_col,pvt_col)
        fprintf('ENTERING VARIABLE IS %d \n',pvt_col)
 sol = A(:,end)
        col = A(:,pvt_col )
        if all(col<0) 
            
            run = false
            break
        else
           for i=1:size(col,1)
               if col(i)>0
                   ratio(i) = sol(i)./col(i)
               else
                    ratio(i) =inf
               end
           end
        end
           %to find minimum ratio
           [min_ratio, pvt_row] = min(ratio)
           fprintf('minimum ratio corresponding to pivot row is %d \n',pvt_row)
           fprintf('leaving variable is %d \n',bv(pvt_row))
        bv(pvt_row) = pvt_col
        disp('new basic variables (bv) = ')
        disp(bv) 
        %to identify pivot element
        pvt_key = A(pvt_row,pvt_col)
        %update table for next iteration
        A(pvt_row,:) = A(pvt_row,:)/pvt_key
        for i =1:size(A,1)
            if i~=pvt_row
                A(i,:) = A(i,:)-A(i,pvt_col).*A(pvt_row,:)
            end
        end
            zjcj = zjcj-zjcj(pvt_col).*A(pvt_row,:)
     %to print updated table
            zjcj1=[zjcj;A]
            cons=array2table(zjcj)
    else 
            run = false
            fprintf('the current bfs is optimal')
            bfs = bv;
    end
end

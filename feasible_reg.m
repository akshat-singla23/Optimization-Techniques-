function output= feasible_reg(x)
format rat
%write first constraint
%all constraint are of <= sign

x1 = x(:,1);
x2 = x(:,2);
cons1 = round(-x1+(3.*x2)-10);
s1 = cons1>0;
x(s1,:) = [];

%write second constraint
%all constraint are of <= sign

x1 = x(:,1);
x2 = x(:,2);
cons2 = round((x1+x2)-6);
s2 = cons2>0;
x(s2,:) = [];


%write third constraint
%all constraint are of <= sign

x1 = x(:,1);
x2 = x(:,2);
cons3 = round((x1-x2)-2);
s3 = cons3>0;
x(s3,:) = [];

output = x;


end
function [matrix_A, matrix_b] = GetMatrix(a,b,c,d,p,q,number)
    % This function is to get matrix A and matrix B
    
    % Initialization
    x = sym('x',[number number]);
    y = sym('y',[number number]);
    dx = sym('dx',[number number]);
    dy = sym('dy',[number number]);
    
    % Dynamic Equations
    for i = 2:number-1
        for j = 2:number-1
            dx(i,j) = a*x(i,j) + b*y(i,j) + p*(x(i+1,j) + x(i-1,j) + x(i,j+1) + x(i,j-1) - 4*x(i,j));
            dy(i,j) = c*x(i,j) + d*y(i,j) + q*(y(i+1,j) + y(i-1,j) + y(i,j+1) + y(i,j-1) - 4*y(i,j));              
        end
    end
    
    % Data preparation for dx = Ax + bu
    inner_dx1 = reshape(dx(2:number-1,2:number-1).',[],1);
    inner_x1 = reshape(x(2:number-1,2:number-1).',[], 1);
    x_all = reshape(x.',number^2,1);
    
    inner_dy1 = reshape(dy(2:number-1,2:number-1).',[],1);
    inner_y1 = reshape(y(2:number-1,2:number-1).',[], 1);
    y_all = reshape(y.',number^2,1);
    
    dotz = [inner_dx1;inner_dy1];
    z = [inner_x1;inner_y1];
    
    % if all the control are used
    u_x_tmp = setdiff(x_all, inner_x1, 'stable');
    u_y_tmp = setdiff(y_all, inner_y1, 'stable');  

    % Eight edges as control
    % u = [u_x_tmp;u_y_tmp];

    % Four edges as control
    u = u_x_tmp;
    


    number_u = size(u,1);
    
    
    all_variables = [z;u];
    P = [dotz == 0];
    eqns = P;
    vars = [all_variables];
    A_u = equationsToMatrix(eqns,vars);
    
    matrix_A = A_u(:,1:2*(number-2)^2);
    size(matrix_A)
    matrix_b = A_u(:,2*(number-2)^2+1:2*(number-2)^2+number_u);
    size(matrix_b)
end












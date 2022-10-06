clc;
clear;
close all;

%% Parameters

a = 2; b = 1; c = 1; d = 1; p = 1; q = 1; % choose the parameters that you want, this is just an example
tf = 5; % final time (can choose by yourself)
number = 20; % spatially discretization
sample_size = 10; % sample size
% if number and sample_size are chosen to be larger, the results should be more accurate but more time-consuming.

%% Initial and Final state
% Two morphogens are denoted as X and Y
% Initial pattern RGB space

[initial_state, final_state] = design_pattern(number);
disp("Pattern has designed and shown as figures.")
% Here initial state is (X0;Y0) and final state is (XT;YT)

%% Matrix A and Matrix B

[matrix_A, matrix_b] = GetMatrix(a,b,c,d,p,q,number);
disp("Matrix_A and Matrix_b are computed")
% In this method, we do not need matrix A and b

% Transform matrix_A and matrix_b from sym into double 
% Aeq and beq only accept double
matrix_A = double(matrix_A);
matrix_b = double(matrix_b);

%% Optimal Parameter

number_u = size(matrix_b,2); % How many control we use here
initial_u = repmat([0],number_u*sample_size,1);  

A = [];B = [];

k = 1;
tmp = matrix_b;
Aeq_tmp = [matrix_b];
while k < sample_size
    tmp = matrix_A * tmp;
    Aeq_tmp = [tmp Aeq_tmp];
    k = k+1;
end
Aeq = Aeq_tmp*tf/sample_size;
size(Aeq)
% beq = final_state;
beq = final_state - matrix_A^sample_size*initial_state;
% if you take the same initial 0, then beq = final_state
% if not beq = final_state - matrix_A^4*initial_state;

Lb = [];Ub = [];

cost_f=@(u) cost_function(u,tf,sample_size);

nonlcon=@(para) nonlcon_function(para);

options = optimoptions('fmincon', ...
                        'Algorithm', 'interior-point',...
                        'Display', 'iter-detailed',...
                        'MaxIterations', 2000,'MaxFunctionEvaluations',1000000000);

[optimal_u,cost]=fmincon(cost_f,initial_u,A,B,Aeq,beq,Lb,Ub,nonlcon,options); 
cost   % final cost


%% Plot 
plotresults(initial_state,tf,sample_size,number_u,optimal_u,matrix_A,matrix_b,number)

%% Cost function 
function cost=cost_function(u,tf,sample_size)
dt = tf/sample_size;
cost = sum(u.^2)*dt;    % minimal energy
end

%% Nonlinear constraints
% we do not have nonlinear constraints here
function [c,ceq]=nonlcon_function(para)
    c=[];
    ceq=[];
end


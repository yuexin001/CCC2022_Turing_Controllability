function [initial_state, final_state] = design_pattern(number)
    % Initial state
    X_ini = zeros(number,number,3);
    Y_ini = zeros(number,number,3);

    figure
    K_ini = imadd(X_ini, Y_ini);
    image(K_ini)
    
    % here initial state is black
    % you can design your own initial state
    X0 = X_ini(:,:,1); 
    X0 = X0(2:number-1,2:number-1).';
    X0_vector = reshape(X0,[],1);
    
    Y0 = Y_ini(:,:,2);
    Y0 = Y0(2:number-1,2:number-1).';
    Y0_vector = reshape(Y0,[],1);
    
    % vector form Initial place
    initial_state = [X0_vector;Y0_vector]*100 ; 

    % Final pattern that you designed
    % Final pattern RGB space
    X = zeros(number,number,3);
    Y = zeros(number,number,3);

    %***********************************%
    %*****Design your final pattern*****%
    %***********************************%
    X(3:7,1:4,1)=1;   X(2:6,5:8,1)=1;   X(1:5,9:12,1)=1;   X(2:6,13:16,1)=1;   X(3:7,17:20,1)=1;
    X(8:12,1:4,1)=1;  X(7:11,5:8,1)=1;  X(6:12,9:12,1)=1;  X(7:11,13:16,1)=1;  X(8:12,17:20,1)=1 ;
    X(13:16,1:4,1)=1; X(12:15,5:8,1)=1; X(11:14,9:12,1)=1; X(12:15,13:16,1)=1; X(13:16,17:20,1)=1;
    X(17:20,1:4,1)=0; X(16:19,5:8,1)=0; X(15:18,9:12,1)=0; X(16:19,13:16,1)=0; X(17:20,17:20,1)=0;

    Y(3:7,1:4,2)=0;    Y(2:6,5:8,2)=0;    Y(1:5,9:12,2)=0;    Y(2:6,13:16,2)=0;    Y(3:7,17:20,2) = 0;
    Y(8:12,1:4,2)=1;   Y(7:11,5:8,2)=1;   Y(6:12,9:12,2)=1;   Y(7:11,13:16,2)=1;   Y(8:12,17:20,2) =1 ;
    Y(13:16,1:4,2)=0.5;Y(12:15,5:8,2)=0.5;Y(11:14,9:12,2)=0.5;Y(12:15,13:16,2)=0.5;Y(13:16,17:20,2) = 0.5;
    Y(17:20,1:4,2)=1;  Y(16:19,5:8,2)=1;  Y(15:18,9:12,2)=1;  Y(16:19,13:16,2)=1;  Y(17:20,17:20,2) = 1;
    
    % figure with control
    figure
    K_final = imadd(X, Y);
    image(K_final)

    % % figure without control
    % X_fig = X(2:number-1,2:number-1,:);
    % Y_fig = Y(2:number-1,2:number-1,:);
    % figure
    % K_final = imadd(X_fig, Y_fig);
    % image(K_final)

    XT = X(:,:,1);
    XT = XT(2:number-1,2:number-1).';
    XT_vector = reshape(XT,[],1);
    
    YT = Y(:,:,2);
    YT = YT(2:number-1,2:number-1).';
    YT_vector = reshape(YT,[],1);
    
    % vector form final place
    final_state = [XT_vector;YT_vector]*100; 
    % *100 is to make the optimization process more stable.In the plot function, the normalization will make it no effect on figure
    
    % Or set the initial state base on the final state
    % r1 = rand(size(final_state,1),1);
    % initial_state = final_state + r1;

end
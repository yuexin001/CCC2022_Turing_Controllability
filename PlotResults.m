function [] = PlotResults(initial_state,tf,sample_size,number_u,optimal_u,matrix_A,matrix_b,number)
    state_now = initial_state;
    figure_number = 1;
    for i = 1:1:sample_size
        u_tmp = optimal_u(number_u*(i-1)+1 : number_u*i); % u 
        state_tmp = matrix_A * state_now + matrix_b * u_tmp * tf/sample_size;
        state_tmp_fig = state_tmp/100;
        % size(state_tmp_fig)
    
        X1_vector = state_tmp_fig(1:(number-2)^2);
        X1 = reshape(X1_vector, number-2, number-2);
        Y1_vector = state_tmp_fig((number-2)^2+1:2*(number-2)^2);
        Y1 = reshape(Y1_vector, number-2, number-2);
        X_1_fig = zeros(number-2,number-2,3);
        Y_1_fig = zeros(number-2,number-2,3);
        X_1_fig(:,:,1) = X1.';
        Y_1_fig(:,:,2) = Y1.';
        
        figure
        K1 = imadd(X_1_fig, Y_1_fig);
        image(K1)
        axis off; 
        
        set(gcf,'Units','Inches');
        pos=get(gcf,'Position');
        set(gcf, 'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3),pos(4)]);
        saveas(gcf,['C:\Users\Mr.Reliable\Desktop\',num2str(figure_number),'.pdf'])    % path where you want to save the files
        
        figure_number = figure_number + 1;
        state_now = state_tmp;
    end
end
clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #3
% Brian Doan, Derek Lee


%% Constants

N = 100;

n_vals = [ 25, 50, 75 ];
lambda_1 = [ 0.5; 1 ];
lambda_2 = [ 0.75; 1.5 ];

mse_poiss_1 = zeros( length(lambda_1), length(n_vals) );
mse_poiss_2 = zeros( length(lambda_2), length(n_vals) );
bias_poiss_1 = zeros( length(lambda_1), length(n_vals) );
bias_poiss_2 = zeros( length(lambda_2), length(n_vals) );


%% Extra Credit

for i = 1:length(n_vals)
    
    n = n_vals(i);
    
    % Generate the data
    data_poisson_1 = poissrnd( lambda_1 * ones(1,n) );
    data_poisson_2 = poissrnd( lambda_2 * ones(1,N-n) );
    data_poisson = [ data_poisson_1 data_poisson_2 ];
    
    % Brute force the max-likelihood estimate
    curMaxProb = -1e5;
    best_lambda_1 = 0;
    best_lambda_2 = 0;
    best_n = 0;
    for j = 2:N-1
        
        % Log likelihood is maximized when 
        %       lambda_1 = 1/n * sum(k) from 1 to n
        %       lambda_2 = 1/(N-n) * sum(k) from n+1 to N
        lambda_est_1 = sum( data_poisson(:,1:j), 2 ) / j;
        lambda_est_2 = sum( data_poisson(:,j+1:end), 2 ) / (N-j);
        
        curProb = sum( log(calcPoisson( data_poisson(:,1:j), lambda_est_1 )), 2 );
        curProb = curProb + sum( log(calcPoisson( data_poisson(:,j+1:end), ...
                    lambda_est_2 )), 2 );
        
        % Reassign the new maximum
        if curProb > curMaxProb
            
            curMaxProb = curProb;
            best_lambda_1 = lambda_est_1;
            best_lambda_2 = lambda_est_2;
            best_n = j;

        end
        
    end
    
    % Calculate MSE
    mse_poiss_1(:,i) = calcMSE(best_lambda_1, lambda_1);
    mse_poiss_2(:,i) = calcMSE(best_lambda_2, lambda_2);

    % Calculate Bias
    bias_poiss_1(:,i) = calcBias(best_lambda_1, lambda_1); 
    bias_poiss_2(:,i) = calcBias(best_lambda_2, lambda_2);
    
end

% Plot MSE
plotDataEC(mse_poiss_1, lambda_1, "MSE", "Poisson MSE Lambda 1");
plotDataEC(mse_poiss_2, lambda_2, "MSE", "Poisson MSE Lambda 2");

% Plot Bias
plotDataEC(bias_poiss_1, lambda_1, "Bias", "Poisson Bias Lambda 1");
plotDataEC(bias_poiss_2, lambda_2, "Bias", "Poisson Bias Lambda 2");


clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #3
% Brian Doan, Derek Lee


%% Constants

N = 100;

n_vals = [ 25, 50, 75 ];
lambda_1 = [ 3; 4 ];
lambda_2 = [ 5; 2 ];

n_pred = zeros( length(n_vals), 2 );
mse_poiss_1 = zeros( length(lambda_1), length(n_vals) );
mse_poiss_2 = zeros( length(lambda_2), length(n_vals) );
bias_poiss_1 = zeros( length(lambda_1), length(n_vals) );
bias_poiss_2 = zeros( length(lambda_2), length(n_vals) );

lambda_best_1 = zeros( length(lambda_1), 1 );
lambda_best_2 = zeros( length(lambda_1), 1 );
n_best = zeros( length(lambda_1), 1 );


%% Extra Credit

for i = 1:length(n_vals)
    
    n = n_vals(i);
    
    % Generate the data
    data_poisson_1 = poissrnd( lambda_1 * ones(1,n) );
    data_poisson_2 = poissrnd( lambda_2 * ones(1,N-n) );
    data_poisson = [ data_poisson_1 data_poisson_2 ];
    
    % Brute force the max-likelihood estimate
    curMaxProb = -1e5;
    for j = 2:N-1
        
        % Log likelihood is maximized when 
        %       lambda_1 = 1/n * sum(k) from 1 to n
        %       lambda_2 = 1/(N-n) * sum(k) from n+1 to N
        lambda_temp_1 = sum( data_poisson(:,1:j), 2 ) / j;
        lambda_temp_2 = sum( data_poisson(:,j+1:end), 2 ) / (N-j);
        
        curProb = sum( log(calcPoisson( data_poisson(:,1:j), lambda_temp_1 )), 2 );
        curProb = curProb + sum( log(calcPoisson( data_poisson(:,j+1:end), ...
                    lambda_temp_2 )), 2 );
        
        % Reassign the new maximum
        tempNs = j*ones(length(lambda_1),1);
        inds = (curProb > curMaxProb) > 0;
        curMaxProb = max(curMaxProb, curProb);
        lambda_best_1(inds) = lambda_temp_1(inds);
        lambda_best_2(inds) = lambda_temp_2(inds);
        n_best(inds) = tempNs(inds);

    end
    
    n_pred(i,:) = n_best;
    
    % Calculate MSE
    mse_poiss_1(:,i) = calcMSE(lambda_best_1, lambda_1);
    mse_poiss_2(:,i) = calcMSE(lambda_best_2, lambda_2);

    % Calculate Bias
    bias_poiss_1(:,i) = calcBias(lambda_best_1, lambda_1); 
    bias_poiss_2(:,i) = calcBias(lambda_best_2, lambda_2);
    
end


%% Plot

% Plot MSE
plotDataEC(mse_poiss_1, lambda_1, "MSE", "Poisson MSE Lambda 1");
plotDataEC(mse_poiss_2, lambda_2, "MSE", "Poisson MSE Lambda 2");

% Plot Bias
plotDataEC(bias_poiss_1, lambda_1, "Bias", "Poisson Bias Lambda 1");
plotDataEC(bias_poiss_2, lambda_2, "Bias", "Poisson Bias Lambda 2");


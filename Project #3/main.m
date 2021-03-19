clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #3
% Brian Doan, Derek Lee


%% Constants

load( 'data.mat' );
NUM_OBSERVATIONS = 1e5;
lambda = [ 0.1; 0.2; 0.3 ];


%% Part 1

range = logspace( 1, log10(NUM_OBSERVATIONS), log10(NUM_OBSERVATIONS) );
mse_exp = zeros( 3, length(range) );
mse_rayl = zeros( 3, length(range) );

% Plot a range of lambdas for a range of observations
for numObv = range
    
    % Used for indexing
    i = log10(numObv);
    
    % Generates a [ length(lambda) by numObv ] matrix
    % Each row represents one value of lambda
    data_exp = exprnd( lambda * ones(1,numObv) );
    data_rayl = raylrnd( lambda * ones(1,numObv) );
    
    % Get true values
    true_exp = calcExp( data_exp, lambda );
    true_rayl = calcRayl( data_rayl, lambda );
    
    % Log likelihood is maximized when lambda = 1/mean(x)
    lambda_hat_exp = mean( data_exp, 2 );
%     disp(lambda_exp_hat)
    
    % Log likelihood is maximized when lambda = sqrt( 1/2n * sum(x^2) )
    lambda_hat_rayl = sum( data_rayl.^2, 2 ) / ( 2*length(data_rayl) );
    lambda_hat_rayl = sqrt(lambda_hat_rayl);
%     disp(lambda_rayl_hat)

    % Get estimates
    est_exp = calcExp( data_exp, lambda_hat_exp );
    est_rayl = calcRayl( data_rayl, lambda_hat_rayl );

    % Calculate MSE
    mse_exp(:,i) = calcMSE( est_exp, true_exp );
    mse_rayl(:,i) = calcMSE( est_rayl, true_rayl );

end


% Plot
figure();
hold on;

for i = 1:length(lambda)
   
    semilogy( mse_rayl(i,:), 'DisplayName', "Ray " + lambda(i) );
    semilogy( mse_exp(i,:), 'DisplayName', "Exp " + lambda(i) );

end

% end

xlim( [0, max(log10(range))+1] );
legend();
hold off;

%% Part 2

[ param_exp, ~ ] = mle( data, 'distribution', 'Exponential' );
[ param_rayl, ~ ] = mle( data, 'distribution', 'Rayleigh' );

% The distribution in data is probably drawn from a Rayleigh distribution,
%       since the 


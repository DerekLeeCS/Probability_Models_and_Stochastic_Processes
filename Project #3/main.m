clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #3
% Brian Doan, Derek Lee


%% Constants

load( 'data.mat' );
NUM_TRIALS = 1e3;
NUM_OBSERVATIONS = 500;
lambda = [ 0.5; 1; 2 ];


%% Part 1

range = 1:NUM_OBSERVATIONS;

% Preallocate matrices
mse_exp = zeros( length(lambda), length(range) );
mse_rayl = zeros( length(lambda), length(range) );
bias_exp = zeros( length(lambda), length(range) );
bias_rayl = zeros( length(lambda), length(range) );
var_exp = zeros( length(lambda), length(range) );
var_rayl = zeros( length(lambda), length(range) );

% Plot a range of lambdas for a range of observations
for numObv = range
    
    % Used for indexing
    i = numObv;
    
    % Generates a [ length(lambda) by numObv ] matrix
    % Each row represents one value of lambda
    data_exp = exprnd( repmat( lambda, [1,numObv,NUM_TRIALS] ) );
    data_rayl = raylrnd( repmat( lambda, [1,numObv,NUM_TRIALS] ) );
    
    % Log likelihood is maximized when lambda = 1/mean(x)
    lambda_hat_exp = calcLambdaExp( data_exp );
%     disp(lambda_hat_exp)
    
    % Log likelihood is maximized when lambda = sqrt( 1/2n * sum(x^2) )
    lambda_hat_rayl = calcLambdaRayl( data_rayl );
%     disp(lambda_rayl_hat)

    % Calculate variance
    var_exp(:,i) = var( lambda_hat_exp, 0, 2 );
    var_rayl(:,i) = var( lambda_hat_rayl, 0, 2 );

    % Get estimated lambda
    lambda_hat_exp = mean( lambda_hat_exp, 2 );
    lambda_hat_rayl = mean( lambda_hat_rayl, 2 );
        
    % Calculate MSE
    mse_exp(:,i) = calcMSE( lambda_hat_exp, lambda );
    mse_rayl(:,i) = calcMSE( lambda_hat_rayl, lambda );
    
    % Calculate bias
    bias_exp(:,i) = calcBias( lambda_hat_exp, lambda );
    bias_rayl(:,i) = calcBias( lambda_hat_rayl, lambda );

end

    
% Plot MSE
plotData( mse_exp, lambda, "MSE", "Exponential MSE" );
plotData( mse_rayl, lambda, "MSE", "Rayleigh MSE" );

% Plot bias 
plotData( bias_exp, lambda, "Bias", "Exponential Bias" );
plotData( bias_rayl, lambda, "Bias", "Rayleigh Bias" );

% Plot variance
plotData( var_exp, lambda, "Variance", "Exponential Variance" );
plotData( var_rayl, lambda, "Variance", "Rayleigh Variance" );


%% Part 2

% Calculate lambda
pred_exp = calcLambdaExp( data );
pred_rayl = calcLambdaRayl( data );

% Check answer with built-in MATLAB function
[ param_exp, ~ ] = mle( data, 'distribution', 'Exponential' );
[ param_rayl, ~ ] = mle( data, 'distribution', 'Rayleigh' );

% Verify lambda estimation
eps = 1e-5;
assert( abs(pred_exp-param_exp) < eps, "Exponential prediction is incorrect." );
assert( abs(pred_rayl-param_rayl) < eps, "Rayleigh prediction is incorrect." );

% Get the probability of data given the distribution
prob_exp = mean( calcExp( data, pred_exp ) );
prob_rayl = mean( calcRayl( data, pred_rayl ) );

% The distribution in data is probably drawn from a Rayleigh distribution,
%       since the probability of the data is much higher given a Rayleigh
%       distribution.


%% Extra Credit

N = 100;

n_vals = [ 25, 50, 75 ];
lambda_1 = [ 0.5; 1 ];
lambda_2 = [ 0.75; 1.5 ];

for i = 1:length(n_vals)
    
    n = n_vals(i);
    
    % Generate the data
    data_poisson_1 = poissrnd( lambda_1 * ones(1,n) );
    data_poisson_2 = poissrnd( lambda_2 * ones(1,N-n) );
    data_poisson = [ data_poisson_1 data_poisson_2 ];
    
    % Brute force the max-likelihood estimate
    curMaxProb = 0;
    best_lambda_1 = 0;
    best_lambda_2 = 0;
    best_n = 0;
    for j = 1:N
        
        % Log likelihood is maximized when lambda = sqrt( 1/2n * sum(x^2) )
        lambda_est_1 = sum( data_poisson(:,1:j), 2 ) / j;
        lambda_est_2 = sum( data_poisson(:,j+1:end), 2 ) / j;
        
        curProb = sum( calcPoisson( data_poisson(:,1:j), lambda_est_1 ), 2 );
        curProb = curProb + sum( calcPoisson( data_poisson(:,j+1:end), ...
                    lambda_est_2 ), 2 );
                
        if curProb > curMaxProb
            
            curMaxProb = curProb;
            best_lambda_1 = lambda_est_1;
            best_lambda_2 = lambda_est_2;
            best_n = j;

        end
        
    end
    
    a=1;
    
end





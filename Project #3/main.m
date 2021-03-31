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
lambda = [ 1; 5; 10 ];


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
    data_exp = exprnd( repmat( lambda, [1,NUM_TRIALS,numObv] ) );
    data_rayl = raylrnd( repmat( lambda, [1,NUM_TRIALS,numObv] ) );
    
    % Log likelihood is maximized when lambda = 1/mean(x)
    lambda_hat_exp = calcLambdaExp( data_exp );
    
    % Log likelihood is maximized when lambda = sqrt( 1/2n * sum(x^2) )
    lambda_hat_rayl = calcLambdaRayl( data_rayl );

    % Calculate variance
    var_exp(:,i) = var( lambda_hat_exp, 0, 2 );
    var_rayl(:,i) = var( lambda_hat_rayl, 0, 2 );
        
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
prob_exp = sum( log(calcExp( data, pred_exp )) );
prob_rayl = sum( log(calcRayl( data, pred_rayl )) );

% The distribution in data is probably drawn from a Rayleigh distribution,
%       since the probability of the data is much higher given a Rayleigh
%       distribution.


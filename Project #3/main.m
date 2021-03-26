clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #3
% Brian Doan, Derek Lee


%% Constants

load( 'data.mat' );
NUM_OBSERVATIONS = 1e5;
lambda = [ 0.5; 1; 2 ];


%% Part 1

% range = logspace( 1, log10(NUM_OBSERVATIONS), log10(NUM_OBSERVATIONS) );
range = 1:2500;

% Preallocate matrices
mse_exp = zeros( length(lambda), length(range) );
mse_rayl = zeros( length(lambda), length(range) );
bias_exp = zeros( length(lambda), length(range) );
bias_rayl = zeros( length(lambda), length(range) );

% Plot a range of lambdas for a range of observations
for numObv = range
    
    % Used for indexing
%     i = log10(numObv);
    i = numObv;
    
    % Generates a [ length(lambda) by numObv ] matrix
    % Each row represents one value of lambda
    data_exp = exprnd( lambda * ones(1,numObv) );
    data_rayl = raylrnd( lambda * ones(1,numObv) );
    
    % Log likelihood is maximized when lambda = 1/mean(x)
    lambda_hat_exp = calcLambdaExp( data_exp );
%     disp(lambda_hat_exp)
    
    % Log likelihood is maximized when lambda = sqrt( 1/2n * sum(x^2) )
    lambda_hat_rayl = calcLambdaRayl( data_rayl );
%     disp(lambda_rayl_hat)

    % Calculate MSE
    mse_exp(:,i) = calcMSE( lambda_hat_exp, lambda );
    mse_rayl(:,i) = calcMSE( lambda_hat_rayl, lambda );
    
    % Calculate bias
    bias_exp(:,i) = calcBias( lambda_hat_exp, lambda );
    bias_rayl(:,i) = calcBias( lambda_hat_rayl, lambda );

end

% Calculate variance
var_exp = mse_exp - bias_exp.^2;
var_rayl = mse_rayl - bias_rayl.^2;
    
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

%%%%% Theoretical data %%%%%
% Calculate the MSE between two generated Exponentials 
err_expected_exp = calcMSE( exprnd( pred_exp * ones(1,length(data)) ), ...
                            exprnd( pred_exp * ones(1,length(data)) ) );
% Calculate the MSE between two generated Rayleighs
err_expected_rayl = calcMSE( raylrnd( pred_rayl * ones(1,length(data)) ), ...
                            raylrnd( pred_rayl * ones(1,length(data)) ) );
% Calculate the MSE between a generated Exponential and a generated Rayleigh
err_expected_intersect = calcMSE( exprnd( pred_exp * ones(1,length(data)) ), ...
                            raylrnd( pred_rayl * ones(1,length(data)) ) );
                    
%%%%% Real data %%%%%                      
% Calculate the MSE 
err_exp = calcMSE( exprnd( pred_exp * ones(1,length(data)) ), ...
                        data );
err_rayl = calcMSE( raylrnd( pred_rayl * ones(1,length(data)) ), ...
                        data );

% The distribution in data is probably drawn from a Rayleigh distribution,
%       since the MSE between two generated Rayleigh distributions is 
%       similar to the MSE between the data and a generated Rayleigh
%       distribution.
% The MSE between the data and a generated Exponential is similar to the
%       MSE between a generated Rayleigh and a generated Exponential


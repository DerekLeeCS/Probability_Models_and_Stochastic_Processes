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


%% Extra Credit

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
    for j = 2:N-1
        
        % Log likelihood is maximized when 
        %       lambda_1 = 1/n * sum(k) from 1 to n
        %       lambda_2 = 1/(N-n) * sum(k) from n+1 to N
        lambda_est_1 = sum( data_poisson(:,1:j), 2 ) / j;
        lambda_est_2 = sum( data_poisson(:,j+1:end), 2 ) / (N-j);
        
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


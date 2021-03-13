clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #2
% Brian Doan, Derek Lee


%% Scenario 1

% Constants
numDraws = 1e6;

% Distributions
Y = unifrnd( -1,1, [1,numDraws] );
W = unifrnd( -2,2, [1,numDraws] );
X = Y+W;

disp( "Starting Scenario 1..." );

% Bayes
% Calculate experimental MSE
estY = MMSE_Y(X);
MSE_1_bayes_experimental = calcMSE(estY,Y);

% Check theoretical vs. experimental
MSE_1_bayes_theoretical = 1/4;
checkEst( MSE_1_bayes_experimental, MSE_1_bayes_theoretical );
disp( "Bayes: Successful" );

% Linear
% Calculate experimental MSE
estY = LMMSE_Y(X);
MSE_1_linear_experimental = calcMSE(estY,Y);

% Check theoretical vs. experimental
MSE_1_linear_theoretical = 4/15;
checkEst( MSE_1_linear_experimental, MSE_1_linear_theoretical );
disp( "Linear: Successful" + newline() );

theoretical_1 = MMSE_theoretical(X);


%% Scenario 2

% Constants
numDraws = 1e4;
numObservations = 5;
mu_y = 1;
mu_x = mu_y;

% Variables
var_y = 2;
var_r = 1;

disp( "Starting Scenario 2..." );

% Prepare the plot
figure();
hold on;
ColOrd = get(gca,'ColorOrder');

% Loop through pairs of variances
for nObv = 1:numObservations

    % Distributions
    Y = normrnd( mu_y, sqrt(var_y), [1,numDraws] );
    R = normrnd( 0, sqrt(var_r), [nObv,numDraws] );
    X = Y+R;

    % Covariances
    cov_xx = cov(X.');
    cov_xy = zeros( nObv, 1 );
    for j = 1:nObv
        temp = cov( X(j,:), Y );
        cov_xy(j) = temp(2,2);
    end
    
    % Calculate experimental MSE
    a = cov_xx \ cov_xy;    % Equiv to cov_xx^-1 * cov_xy
    estY = MMSE_multiple_Y( X, mu_x, mu_y, a );
    MSE_2_experimental = calcMSE(estY,Y);

    % Check theoretical vs. experimental
    MSE_2_theoretical = var_y - ( (cov_xy).' * a );
    
    % Plot
    line( [nObv,nObv], [ mean(MSE_2_experimental), MSE_2_theoretical ], ... 
            'Color', ColOrd( mod(nObv,length(ColOrd)), : ), ...
            'HandleVisibility', 'off');
    plot( nObv, mean(MSE_2_experimental), 'or', 'HandleVisibility', 'off' );
    plot( nObv, MSE_2_theoretical, 'og', 'HandleVisibility', 'off' );
    
end

% Used for legend only
plot( NaN,NaN,'or', 'DisplayName', 'Experimental' );
plot( NaN,NaN,'og', 'DisplayName', 'Theoretical' );

% Label graph
title( "MSE for Different Number of Observations (var_y = " + var_y + ...
        ", var_r = " + var_r + ")" );
xlabel( "Number of Observations" );
ylabel( "MSE" );
legend();
xlim( [0,numObservations+1] );


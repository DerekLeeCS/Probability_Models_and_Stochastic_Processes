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
numDraws = 1e5;
mu_y = 1;

% Variables
var_y = [3,2,0.5];
var_r = [1,2,0.25];


disp( "Starting Scenario 2..." );

% Prepare the plot
figure();
hold on;
ColOrd = get(gca,'ColorOrder');

% Loop through pairs of variances
for i = 1:length(var_y)

    % Distributions
    Y = normrnd( 0, var_y(i), [1,numDraws] );
    R_1 = normrnd( 0, var_r(i), [1,numDraws] );
    R_2 = normrnd( 0, var_r(i), [1,numDraws] );
    X_1 = Y+R_1;
    X_2 = Y+R_2;

    % Calculate experimental MSE
    estY = MMSE_two_Y( X_1, X_2, mu_y, var_y(i), var_r(i) );
    MSE_2_experimental = calcMSE(estY,Y);

    % Check theoretical vs. experimental
    MSE_2_theoretical = ( var_y(i) * var_r(i) ) / ( 2*var_y(i) + var_r(i) );
%     checkEst( MSE_2_experimental, MSE_2_theoretical );
%     disp( "Linear (Two): Successful" + newline() );
    
    % Plot
    line( [i,i], [ MSE_2_experimental, MSE_2_theoretical ], ... 
            'DisplayName', "var_y: "+var_y(i)+", var_r: "+var_r(i), ...
            'Color', ColOrd( mod(i,length(ColOrd)), : ) );
    plot( i, MSE_2_experimental, 'or', 'HandleVisibility', 'off' );
    plot( i, MSE_2_theoretical, 'og', 'HandleVisibility', 'off' );
    
end

% Used for legend only
plot( NaN,NaN,'or', 'DisplayName', 'Experimental' );
plot( NaN,NaN,'og', 'DisplayName', 'Theoretical' );

% Label graph
title( "MSE for Different Variances" );
xlabel( "Pair Number (for Variances)" );
ylabel( "MSE" );
legend();
xlim( [0,length(var_y)+1] );


clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #2
% Brian Doan, Derek Lee


%% Constants

numDraws = 1e6;


%% Scenario 1

% Distributions
Y = unifrnd( -1,1, [1,numDraws] );
W = unifrnd( -2,2, [1,numDraws] );
X = Y+W;

% Calculate experimental MSE
estY = MMSE_y(X);
MSE_1_experimental = calcMSE(estY,Y);

% Check theoretical vs. experimental
MSE_1_theoretical = 1/4;
checkEst( MSE_1_experimental, MSE_1_theoretical );
disp( "Successful" );

theoretical_1 = MMSE_theoretical(X);
%% Scenario 2



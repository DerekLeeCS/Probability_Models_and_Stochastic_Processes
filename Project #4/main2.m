clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #4 Part 2
% Brian Doan, Derek Lee


%% Constants

load("iris.mat");
C = length( unique(labels) );


%% MAP Estimation on Iris Dataset

% Split the data
[x_train, y_train, x_test, y_test] = splitData(features, labels, 0.5);

% Train and test for each class
pdf_est = zeros( length( y_test ), C );
for i = 1:C
    
    % Get the features associated with a specific class
    class_features = x_train( y_train == i, : );
    p_present = sum( y_train == i ) / length( y_train );
    
    % Estimate the MAP parameters
    mu_est = mean(class_features);
    cov_est = cov(class_features);
    
    % Calculate the likelihood for each sample per class
    pdf_est(:,i) = mvnpdf( x_test, mu_est, cov_est ) * p_present;
    
end

% Get estimates
[~, y_hat] = max(pdf_est, [], 2);
err = calcProbError( y_test', y_hat' );

% Plot Confusion Matrix
confusionchart( y_test, y_hat );
title( "Confusion Matrix for MAP Classification on the Iris Dataset" );


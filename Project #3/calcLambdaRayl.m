function lambda_hat = calcLambdaRayl( data )

    lambda_hat = sum( data.^2, 2 ) / ( 2*length(data) );
    lambda_hat = sqrt(lambda_hat);
    
end
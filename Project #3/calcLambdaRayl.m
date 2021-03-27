function lambda_hat = calcLambdaRayl( data )

    lambda_hat = sum( data.^2, 3 ) / ( 2*size(data,3) );
    lambda_hat = sqrt( lambda_hat );
    
end
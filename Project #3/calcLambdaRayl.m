function lambda_hat = calcLambdaRayl( data )

    lastDim = length( size(data) );
    lambda_hat = sum( data.^2, lastDim ) / ( 2*size(data,lastDim) );
    lambda_hat = sqrt( lambda_hat );
    
end
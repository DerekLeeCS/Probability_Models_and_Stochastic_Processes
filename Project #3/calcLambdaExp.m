function lambda_hat = calcLambdaExp( data )  

    lastDim = length( size(data) );
    lambda_hat = mean( data, lastDim );   
    
end
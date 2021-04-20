function err = calcProbError( Y, Y_hat )

    lastDim = ndims(Y);
    err = Y ~= Y_hat; 
    err = sum( err, lastDim ) / size( Y, lastDim );
    
end
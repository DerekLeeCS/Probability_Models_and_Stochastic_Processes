function bias = calcBias( pred, true )

    pred = mean( pred, 2 );
    bias = sum( (pred-true), 2 )/length(true);
    
end
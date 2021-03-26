function bias = calcBias( pred, true )
    bias = sum( (pred-true), 2 )/length(true);
end
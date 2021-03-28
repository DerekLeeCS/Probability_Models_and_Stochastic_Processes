function err = calcMSE( pred, true )
    err = mean( (pred-true).^2, 2 );
end
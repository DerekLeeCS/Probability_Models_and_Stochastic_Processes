function err = calcMSE( pred, true )
    err = sum( (pred-true).^2, 2 )/size(true,2);
end
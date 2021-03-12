function err = calcMSE( pred, true )

    err = sum( (pred-true).^2 )/length(true);

end
function trials = genFire( numTrials )

    trials = unidrnd( 2, 2, numTrials );
    trials = sum( trials );
    
end
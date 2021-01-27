function willHit = tryAttack( numTrials )

    % Roll needs to be 11 or greater to hit
    rolls = unidrnd( 20, 1, numTrials );
    willHit = rolls >= 11;
    
end
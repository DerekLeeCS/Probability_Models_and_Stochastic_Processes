function abilityScore = calcAbility( trials )

    tempScore = sum( trials, ndims(trials)-1 );
    abilityScore = max( tempScore, [], ndims(trials)-2 );

end
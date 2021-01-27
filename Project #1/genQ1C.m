function trials = genQ1C( maxVal, numAbilities, numFun, numRolls, numTrials )

    % Run Part A trials **numAbilities** times
    trials = zeros( numAbilities, numFun, numRolls, numTrials );
    for i = 1:numAbilities
        trials( i,:,:,: ) = genQ1B( maxVal, numFun, numRolls, numTrials );
    end

end
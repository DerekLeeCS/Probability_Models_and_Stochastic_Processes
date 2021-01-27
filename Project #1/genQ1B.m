function trials = genQ1B( maxVal, numFun, numRolls, numTrials )
    
    % Run Part A trials **numFun** times
    trials = zeros( numFun, numRolls, numTrials );
    for i = 1:numFun
        trials( i,:,: ) = genQ1A( maxVal, numRolls, numTrials );
    end
    
end
function trials = createTrolls( numTrolls, numTrials )

    % Generate trolls **numTrolls** times
    trials = zeros( numTrolls, numTrials );
    for i = 1:numTrolls
       trials(i,:) = genTroll( numTrials ); 
    end

end
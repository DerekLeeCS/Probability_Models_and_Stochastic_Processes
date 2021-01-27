function experimental = calcExperimentalVec( scores, goalVec )

    % Find the number of matching ability vectors
    numMatch = sum( ismember( scores', goalVec, 'rows' ) );

    % Calculate the percentage of matching scores
    experimental = numMatch / size( scores, ndims(scores) );
    
end
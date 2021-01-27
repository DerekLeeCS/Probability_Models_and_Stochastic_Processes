function experimental = calcExperimental( scores, goalScore )
    
    % Find the number of matching scores
    numMatch = sum( scores == goalScore );
    
    % Calculate the percentage of matching scores
    experimental = numMatch / size( scores, ndims(scores) );

end
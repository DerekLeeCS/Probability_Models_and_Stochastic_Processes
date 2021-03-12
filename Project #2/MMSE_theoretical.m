function theoretical = MMSE_theoretical(x)
    
        % Get cases
        % logical array 1 for first range
        temp = (-3 <= x & x < -1);
        % 1 if not in second range and is in first range
        % -1 if in second range
        % 0 if never was in either range
        temp = temp - (1 <= x & x <= 3);
        
        % Evaluate for case
        
       
        %disp(temp);
        % Get (1/12)*(3+x)^2 or (1/12)*(3-x)^2 portion
        % All 1s (temp keeps the same sign as -)
        % All -1s (temp flips signs to +)
        theoretical = (1/12)*(3 + x .* temp).^2; 
        
        % Get 1/3 portion
        % All 0s
        theoretical = theoretical .* (temp~=0);
        theoretical = theoretical + (temp==0) * 1/3;
        
        
end


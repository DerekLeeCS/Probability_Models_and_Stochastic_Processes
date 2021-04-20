function Y = genTarget( A, prob_not_present, sz )

    Y = rand(sz) > prob_not_present;
    Y = Y*A;
    
end
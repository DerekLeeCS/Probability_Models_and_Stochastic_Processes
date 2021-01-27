clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #1
% Brian Doan, Derek Lee


%% Constants

NUM_TRIALS = 1e6;
MAX_VAL = 6;


%% Question 1 Part A

q1aTheoretical = (1/MAX_VAL)^3;

% Run trials
q1aTrials = genQ1A( MAX_VAL, 3, NUM_TRIALS );

% Calculate ability scores
q1aAbilityScore = sum( q1aTrials );

% Get matches
q1aExperimental = calcExperimental( q1aAbilityScore, 18 );


%% Question 1 Part B

q1bTheoretical = 1-( 1-q1aTheoretical )^3;

% Run trials
q1bTrials = genQ1B( MAX_VAL, 3, 3, NUM_TRIALS );

% Calculate ability scores
q1bTempScore = sum( q1bTrials, ndims(q1bTrials)-1 );
q1bAbilityScore = max( q1bTempScore, [], 1 );

% Get matches
q1bExperimental = calcExperimental( q1bAbilityScore, 18 );


%% Question 1 Part C

q1cTheoretical = q1bTheoretical^6;

% Run trials
q1cTrials = genQ1C( MAX_VAL, 6, 3, 3, NUM_TRIALS );

% Calculate ability scores
q1cTempScore = sum( q1cTrials, ndims(q1cTrials)-1 );
q1cAbilityScore = max( q1cTempScore, [], ndims(q1cTrials)-2 );
q1cAbilityScore = squeeze( q1cAbilityScore );

% Get matches
q1cExperimental = calcExperimentalVec( q1cAbilityScore, 18*ones(1,6) );


%% Question 1 Part D

%%%%%%%%%%%%%%%%%%%% this is wrong b/c it takes the max of 3 tries
%%%%%%%%%%%%%%%%%%%% so should be P(9 from 3 dice) * ( 1-( P(roll>9)^3 )
q1dTheoretical = ( 1-(1-( 25/(6^3) ) )^3 )^6;

% Run trials
q1dTrials = genQ1C( MAX_VAL, 6, 3, 3, NUM_TRIALS );

% Calculate ability scores
q1dTempScore = sum( q1dTrials, ndims(q1dTrials)-1 );
q1dAbilityScore = max( q1dTempScore, [], ndims(q1dTrials)-2 );
q1dAbilityScore = squeeze( q1dAbilityScore );

% Get matches
q1dExperimental = calcExperimentalVec( q1dAbilityScore, 9*ones(1,6) );


%% Question 2 Part A

q2aTrollTheoretical = 2.5;
q2aFireTheoretical = 3;
q2aGreaterTheoretical = 0.25;

% Run trials
q2aTrollTrials = genTroll( NUM_TRIALS );
q2aFireTrials = genFire( NUM_TRIALS );

% Calculate averages
q2aTrollExperimental = mean( q2aTrollTrials );
q2aFireExperimental = mean( q2aFireTrials );

% Calculate bound
q2aGreaterExperimental = sum( q2aFireTrials > 3 ) / NUM_TRIALS;


%% Question 2 Part B

pmfFire(3);
pmfTroll(2);


%% Question 2 Part C

NUM_TROLLS = 6;
q2cFire = genFire( NUM_TRIALS );
q2cTrolls = createTrolls( NUM_TROLLS, NUM_TRIALS );

% Determine if a troll died
q2cDead = q2cFire >= q2cTrolls;

% Count number of times all trolls died
q2cAllDead = sum( sum( q2cDead, ndims(q2cDead)-1 ) == NUM_TROLLS );

% Calculate probability
q2cExperimental = q2cAllDead / NUM_TRIALS;


%% Question 2 Part D

NUM_TROLLS = 6;
q2dFire = genFire( NUM_TRIALS );
q2dTrolls = createTrolls( NUM_TROLLS, NUM_TRIALS );

% Determine if a troll died
q2dDead = q2dFire >= q2dTrolls;

% Get trials with one surviving troll
q2dAllDead = sum( q2dDead, ndims(q2dDead)-1 ) == NUM_TROLLS-1;
q2dSurvivingTroll = max( q2dTrolls, [], 1 ) .* q2dAllDead;

% Calculate probability
q2dExperimental = mean( q2dSurvivingTroll( q2dSurvivingTroll>0 ) );


%% Question 2 Part E

% Roll damage
q2eDmgSword = unidrnd( 6, 2, NUM_TRIALS );
q2eDmgSword = sum( q2eDmgSword, ndims( q2eDmgSword )-1 );
q2eDmgHammer = unidrnd( 4, 1, NUM_TRIALS );

% Determine if attack will hit
q2eAttackSword = tryAttack( NUM_TRIALS );
q2eDmgSword = q2eDmgSword .* q2eAttackSword;

% Determine if the hammer attack will hit
q2eAttackHammer = q2eAttackSword .* tryAttack( NUM_TRIALS );
q2eDmgHammer = q2eDmgHammer .* q2eAttackHammer;

% Calculate expected damage
q2eExperimental = mean( q2eDmgSword + q2eDmgHammer );


%% Question 2 Part F

q2fTheoretical = 1;


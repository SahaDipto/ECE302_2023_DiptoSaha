
% question 2c
hp = 4;
dmg = 2;

q2c_sim = q2c(numTrials,hp,dmg,6,6);

function [out] = q2c(target,hp,dmg,numEnemies,numDead)
    % generate enemy array using randi([1,4]) with dimensions of numEnemies by target
    % generate dmg array using randi([1,2]) + randi([1,2]) with dimensions of numEnemies by target
    % apply inequality statement dmg >= hp to convert to logic array
    % sum logic array vertically
    % apply equality statement of numDead
    % sum logic array horizontally and divide by target
    out = sum(sum( (repmat((randi([1,dmg],1,target) + randi([1,dmg],1,target)),numEnemies,1) >= randi([1,hp],numEnemies,target)) ,1) == numDead)/target;
end

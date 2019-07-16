pragma solidity ^0.5.0;

import "./HeroHelper.sol";

contract HeroAttack is HeroHelper {
    uint randNonce;
    uint attakingProbability = 70;
    function randMod( uint _module) internal returns(uint){
        randNonce++;
        return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _module;
    }
    function attack(uint _heroId,uint _targetId) external {
        require(msg.sender == HerotoOwner[_heroId]);
        uint rand;
        Hero storage myHero = Heros[_heroId];
        Hero storage villain = Heros[_targetId];
        rand = randMod(100);
        if(rand < attakingProbability){
            myHero.winCount++;
            myHero.level++;
            villain.lossCount++;
            FigthAndInclude(_heroId,_targetId);
        }else{
            myHero.lossCount--;
            villain.winCount++;
        }
         _triggerDownHero(myHero);
    }
}

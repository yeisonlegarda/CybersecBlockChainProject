pragma solidity ^0.5.0;
import "./HeroAvatar.sol";


contract kittyInterface {
    function getKitty(uint256 _id) external view returns(
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 stringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
        );
}

contract HeroWar is HeroAvatar {

    address ckAdrress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

    kittyInterface myKitty = kittyInterface(ckAdrress);

    function _triggerDownHero(Hero storage myHero) internal{
        myHero.readyTime = uint32(1 days + now);
    }

    function _isReady(Hero storage myHero) internal view returns(bool) {
        return (myHero.readyTime <= now);
    }

    function FigthAndInclude(uint _heroId, uint _villainId) public{

        require(HerotoOwner[_heroId]==msg.sender);
        Hero storage myHero = Heros[_heroId];
        require(_isReady(myHero));
        Hero storage myVillain = Heros[_villainId];
        uint _skill = myVillain.skill;
        _skill = _skill % SkillModulus;
        uint newType = (myHero.typeOfHero + myVillain.typeOfHero );
        uint newSkill = (myHero.skill + _skill)/2;
        _createHero("newHero",newSkill,newType);
        _triggerDownHero(myHero);
    }
    function figthWithKitty(uint _heroId, uint _kittyId) private{
        uint newSkill;
        (,,,,,,,,,newSkill) = myKitty.getKitty(_kittyId);
        FigthAndInclude(_heroId,newSkill);
    }

    function setKittyContractAddress (address _address) external onlyOwner {
        ckAdrress=_address;
    }
}

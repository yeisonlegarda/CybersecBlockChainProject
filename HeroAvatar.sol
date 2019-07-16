pragma solidity 0.5.0;

import "./Ownable.sol";
contract HeroAvatar is Ownable {
    uint Skill =16;
    uint SkillModulus = 10**16;
    uint coolDownTimer = 15 minutes;
    struct Hero {
        string name;
        uint skill;
        uint typeOfHero;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Hero[] public Heros;
    event heroCreated(string name,uint skill);

    mapping(uint => address) public HerotoOwner;
    mapping(address=>uint) OwnerHeroCount;

    function _createHero(string memory _name, uint _skill,uint _typeOf) internal {
       uint id =  Heros.push(Hero(_name, _skill,_typeOf,1,uint32(now),0,0)) - 1;
       HerotoOwner[id] = msg.sender;
       OwnerHeroCount[msg.sender] ++;
       emit heroCreated(_name,_skill);
    }

    function _generateSkillRandomly(string memory _name) internal returns(uint){
       uint skill = uint(keccak256(bytes(_name)));
       return skill%SkillModulus;
    }

    function generateHeroRandom(string memory _name,uint _typeOf) public {
        require(OwnerHeroCount[msg.sender]==0);
        uint skill = _generateSkillRandomly(_name);
        _createHero(_name,skill,_typeOf);
    }

    function totalHeros() public view returns(uint){
        return Heros.length;
    }
}

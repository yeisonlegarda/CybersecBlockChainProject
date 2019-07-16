pragma solidity ^0.5.0;
import "./HeroWar.sol";


contract HeroHelper is HeroWar{


    uint levelUpFee = 0.01 ether;
    constructor() public{

    }
    modifier aboveLevel(uint heroId,uint _level){
        Heros[heroId].level >_level;
        _;
    }
    function changeName(uint _heroId,string memory _name) public aboveLevel(_heroId,2){
        Heros[_heroId].name = _name;
    }

    function changeSkill(uint _heroId,uint _newSkill) public aboveLevel(_heroId,20){
        Heros[_heroId].skill = _newSkill;
    }

    function getHerosByOwner (address _owner) external view returns(uint[] memory){
        uint[] memory result = new uint[](OwnerHeroCount[_owner]);
        uint count = 0;
        for(uint i=0; i < Heros.length; i++){
            if(HerotoOwner[i]==_owner){
                result[count] = i;
                count ++;
            }
        }
        return result;
    }

    function levelUp(uint _heroId) public payable{
        require(msg.value == levelUpFee);
        Heros[_heroId].level++;
    }


    function withdraw() external onlyOwner {
       address(uint160(owner())).transfer(address(this).balance);
    }

    function changelevelUpFee(uint _fee) external{
        levelUpFee = _fee;
    }
}

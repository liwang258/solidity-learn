// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable{
    mapping(address=>int256) private votedMap;
    address[] private  candidateArr ;

    constructor(address owner)Ownable(owner){

    }

    function vote(address candidate) public  {
        votedMap[candidate]=votedMap[candidate]+1;
        candidateArr.push(candidate);
    }

    function getVotes(address candidate) external view returns (int256){
        return votedMap[candidate];
    }

    function resetVotes() external onlyOwner returns(bool){
        for(uint256 i=0;i<candidateArr.length;i++){
            delete votedMap[candidateArr[i]];
          candidateArr[i]= candidateArr[candidateArr.length-1];
          candidateArr.pop();
        }
        return true;
    }
}
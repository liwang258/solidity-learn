// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ReverseString{
    function revertString(string calldata input) public pure returns(string memory){
        bytes memory b=bytes(input);
        bytes memory v=new bytes(b.length);
        for(uint256 i=0;i<b.length;i++){
            v[b.length-1-i]=b[i];
        }
        return string(v);
    }
}
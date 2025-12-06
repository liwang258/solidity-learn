// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeggingContract is Ownable {
    mapping(address => uint256) private donateMap;
    uint256 private totalAmount;
    address[3] private donateRank;
    uint256 private donateStartStampTime;
    uint256 private donateEndStampTime;


    constructor(address owner,uint256 startTime,uint256 endTime) Ownable(owner) {
        donateStartStampTime=startTime;
        donateEndStampTime=endTime;
    }

    event EventDonate(address indexed  donator, uint256 indexed  amount);

    function donate() public payable {
        require(msg.value > 0);
        require(block.timestamp>donateStartStampTime&&block.timestamp<donateEndStampTime);
        donateMap[msg.sender] = msg.value;
        totalAmount = totalAmount + msg.value;
        for (uint256 i = 0; i < donateRank.length; i++) {
            if (donateMap[donateRank[i]] < msg.value) {
                donateRank[i] = msg.sender;
            }
        }
        emit EventDonate(msg.sender, msg.value);
    }

    function getDonation(address des) external view returns (uint256) {
        return donateMap[des];
    }

    function withdraw(address payable to) public payable onlyOwner {
        require(to != address(0));
        require(totalAmount > 0);
        uint256 transferAmt = totalAmount;
        totalAmount = 0;
        to.transfer(transferAmt);
    }

    function getTotalAmount() public view returns (uint256) {
        return totalAmount;
    }

    
    function getDonateRank() public view returns (address[3] memory){

        return donateRank;
    }
}

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    struct Wave {
        address addr;
        string message;
        uint256 timestamp;
    }

    uint256 private seed;
    uint256 private totalWaves;
    Wave[] private waves;
    uint256 private prize = 0.0001 ether;
    mapping(address => uint256) public userCooldown;

    event NewWave(address indexed _from, string _message, uint256 _timestamp);

    constructor() payable {
        console.log("Contract is up and running");

        seed = ( block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(userCooldown[msg.sender] < block.timestamp, "Please do not spam!");
        totalWaves += 1;
        waves.push(Wave(msg.sender, _message, block.timestamp));
        console.log("%s", _message);
        userCooldown[msg.sender] = block.timestamp + 30 seconds; 
        emit NewWave(msg.sender, _message, block.timestamp);
        seed = ( block.timestamp + block.difficulty + seed) % 100;

        if (seed <= 50 ){
            console.log("%s has won !", msg.sender);
            require(prize <= address(this).balance, "Not enough money in the balance to give a prize");
            (bool success, ) = (msg.sender).call{value: prize}("");
            require(success, "Failed to send the prize");
        }
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}
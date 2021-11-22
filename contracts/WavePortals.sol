// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    struct Wave {
        address addr;
        string message;
        uint256 timestamp;
    }

    uint256 totalWaves;
    Wave[] waves;
    uint256 prize = 0.0001 ether;

    event NewWave(address indexed _from, string _message, uint256 _timestamp);

    constructor() payable {
        console.log("Contract is up and running");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        waves.push(Wave(msg.sender, _message, block.timestamp));
        console.log("%s", _message);
        emit NewWave(msg.sender, _message, block.timestamp);

        require(prize <= address(this).balance, "Not enough money in the balance to give a prize");
        (bool success, ) = (msg.sender).call{value: prize}("");
        require(success, "Failed to send the prize");
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}
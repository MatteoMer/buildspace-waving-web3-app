// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) totalWavesByAddress;

    constructor() {
        console.log("Here's a screenshot for you buildspace :D");
    }

    function wave() public {
        totalWaves += 1;
        totalWavesByAddress[msg.sender] += 1;
        console.log("Oh! %s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves! Impressive !", totalWaves);
        return totalWaves;
    }

    function getTotalWavesByAddress(address _addr) public view returns (uint256) {
        console.log("%s has waved %d times to me, wow !", _addr, totalWavesByAddress[_addr]);
        return totalWavesByAddress[_addr];
    }


}
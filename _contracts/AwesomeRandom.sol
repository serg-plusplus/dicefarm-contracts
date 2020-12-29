//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "hardhat/console.sol";

contract AwesomeRandom {
    string currentMolfarSeedHash;

    constructor(string memory _molfarSeedHash) {
        console.log(
            "Deploying a AwesomeRandom with molfar seed hash:",
            _molfarSeedHash
        );
        currentMolfarSeedHash = _molfarSeedHash;
    }

    function commit(
        string memory _newMolfarSeedHash,
        string memory prevMolfarSeed
    ) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}

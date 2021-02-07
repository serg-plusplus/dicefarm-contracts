// contracts/DiceFarm.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DiceFarm is Ownable {
    using SafeMath for uint256;
    using SafeMath for uint8;
    using SafeERC20 for IERC20;
    using Counters for Counters.Counter;

    enum RollType {Under, Over}

    struct RollLimit {
        uint8 min;
        uint8 max;
    }

    struct Bet {
        uint256 nonce,
        address player,
        uint256 blockNumber,
        RollType rollType,
        uint256 rollValue,
        address asset,
        uint256 amount,
        bytes randomSeed
    }

    struct Player {
        uint256 block;
        uint256 betNonce;
        address betAsset;
        uint256 betAmount;
        uint256 winChance;
        uint8 rollResult;
        Stage stage;
    }

    struct Asset {
        uint256 minBetAmount;
        uint256 maxBetAmount;
        address liquidity;
    }

    Counters.Counter public betNonce;
    uint8 public rtpRate = 98;
    uint8 public minWinChance = 2;
    uint8 public maxWinChance = 96;
    bytes public houseRandomHash;

    mapping(RollType => RollLimit) public rollLimits;
    mapping(address => Asset) public assets;
    Bet[] public betPool;

    constructor(_houseRandomHash) Ownable() {
        rollLimits[RollType.Under] = {
            min: minWinChance + 1,
            max: maxWinChance + 1
        };
        rollLimits[RollType.Over] = {
            min: 100 - maxWinChance,
            max: 100 - minWinChance
        };

        houseRandomHash = _houseRandomHash
    }

    function bet(
        RollType _rollType,
        uint256 _rollValue,
        address _asset,
        uint256 _amount,
        bytes memory _randomSeed
    ) public returns (uint256) {
        require(
            rollValue <= rollLimits[_rollType].max &&
            rollValue >= rollLimits[_rollType].min,
            "Roll value out of limits"
        );

        uint256 nonce = betNonce.current();

        betPool.push(
            Bet(
                nonce,
                msg.sender,
                block.number,
                _rollType,
                _rollValue,
                _asset,
                _amount,
                _randomSeed
            )
        );

        betNonce.increment();
        nonce;
    }

    function commit(
        bytes memory houseRandomSeed,
        bytes memory houseRandomSalt
    ) public onlyOwner {
        // Check if house seed valid

        delete betPool;
    }
}

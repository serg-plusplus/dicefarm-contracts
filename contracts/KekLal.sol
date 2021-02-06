// contracts/KekLal.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract KekLal is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Counter private _lootboxIds;

    uint8 public constant MIN_ITEMS_IN_LOOTBOX = 2;
    uint8 public constant MAX_ITEMS_IN_LOOTBOX = 20;

    uint8 public constant MIN_ODDS = 1;
    uint32 public constant MAX_ODDS = 100000;

    constructor() ERC1155("https://game.example/api/item/{id}.json") {}

    function craft(
        address from,
        address to,
        uint256 amount,
        address[] calldata itemAddresses,
        uint256[] calldata itemIds,
        uint256[] calldata itemShares
    ) public returns (uint256) {
        require(
            itemAddresses.length == itemIds.length &&
                itemAddresses.length == itemShares.length,
            "KekLal: items length mismatch"
        );

        uint256 newLootboxId = _lootboxIds.current();

        for (uint256 i = 0; i < itemAddresses.length; ++i) {
            uint256 share = itemShares[i];
            require(share > 0);
        }

        _lootboxIds.increment();

        _mint(msg.sender, newLootboxId, 1, "");
    }
}

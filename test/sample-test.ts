import { expect } from "chai";
import { ethers } from "hardhat";

describe("GameItems", function () {
  it("Should return the new greeting once it's changed", async function () {
    const GameItems = await ethers.getContractFactory("GameItems");
    const gameItems = await GameItems.deploy();

    await gameItems.deployed();
    expect(await gameItems.GOLD()).to.equal(ethers.BigNumber.from(0));
    expect(
      await gameItems.balanceOf(
        "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
        ethers.BigNumber.from(2)
      )
    ).to.equal(1);
  });
});

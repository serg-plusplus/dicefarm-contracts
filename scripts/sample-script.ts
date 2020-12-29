import { run, ethers } from "hardhat";

async function main() {
  await run("compile");

  // We get the contract to deploy
  const GameItems = await ethers.getContractFactory("GameItems");
  const gameItems = await GameItems.deploy();

  console.log("GameItems deployed to:", gameItems.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

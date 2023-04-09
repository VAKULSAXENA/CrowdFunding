// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const Spider = await hre.ethers.getContractFactory("Spider");
  const spider = await Spider.deploy();

  await spider.deployed();

  console.log(
    `Address of Spider ERC20 Token on Polygon Mumbai is: ${spider.address}`
  );

  const CrowdFund = await hre.ethers.getContractFactory("Crowdfund");
  const crowdfund = await CrowdFund.deploy(spider.address);

  await crowdfund.deployed();

  console.log(
    `Address of CrowdFund on Polygon Mumbai is: ${crowdfund.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

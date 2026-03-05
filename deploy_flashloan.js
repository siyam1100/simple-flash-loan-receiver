const hre = require("hardhat");

async function main() {
  // Aave V3 Pool Addresses Provider (Example for Ethereum Mainnet)
  const POOL_ADDRESS = "0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e";

  const FlashLoan = await hre.ethers.getContractFactory("FlashLoanReceiver");
  const flashLoan = await FlashLoan.deploy(POOL_ADDRESS);

  await flashLoan.waitForDeployment();

  console.log("Flash Loan Receiver deployed to:", await flashLoan.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

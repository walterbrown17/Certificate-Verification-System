const { ethers } = require("hardhat");

async function main() {
  const CertificateVerification = await ethers.getContractFactory("CertificateVerification");
  const contract = await CertificateVerification.deploy();
  await contract.deployed();

  console.log("CertificateVerification deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Deployment failed:", error);
    process.exit(1);
  });

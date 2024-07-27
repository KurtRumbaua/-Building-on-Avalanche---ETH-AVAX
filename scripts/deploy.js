async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Get the contract factory
    const DegenToken = await ethers.getContractFactory("DegenToken");

    // Set the initial supply (adjust the value as needed)
    const initialSupply = ethers.utils.parseUnits("1000", 18); 

    // Deploy the contract
    const degenToken = await DegenToken.deploy(initialSupply);
    await degenToken.deployed();

    console.log("DegenToken deployed to:", degenToken.address);
}

// Execute the script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

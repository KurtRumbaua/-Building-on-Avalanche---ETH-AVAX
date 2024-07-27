# DegenToken Project

A project deploying the DegenToken smart contract on the Avalanche Fuji testnet.

## Description

DegenToken is an ERC-20 token with additional functionalities, such as minting, burning, buying items, and a referral system. The project demonstrates the creation and management of an ERC-20 token on the Avalanche network. 

## Getting Started

### Installing

1. Clone the repository:
    ```sh
    git clone https://github.com/KurtRumbaua/-Building-on-Avalanche---ETH-AVAX.git
    cd -Building-on-Avalanche---ETH-AVAX
    ```

2. Install the required dependencies:
    ```sh
    npm install
    npm install @openzeppelin/contracts
    npm install dotenv
    ```

3. Create a `.env` file in the root directory and add the necessary environment variables:
    ```sh
    touch .env
    ```

    Example `.env` file:
    ```env
    AVALANCHE_API_URL=https://api.avax-test.network/ext/bc/C/rpc
    PRIVATE_KEY=your_private_key_here
    ```

### Executing program

1. Compile the smart contract:
    ```sh
    npx hardhat compile
    ```

2. Deploy the smart contract to the Avalanche Fuji testnet:
    ```sh
    npx hardhat run scripts/deploy.js --network fuji
    ```

3. Verify the smart contract on Snowtrace:
    ```sh
    npx hardhat verify --network fuji <contract_address> <constructor_arguments>
    ```

## Help

For common problems or issues, you can run the following command to get help information:
    ```sh
    npx hardhat help
    ```

## Authors

Contributors names and contact info:

Kurt Rumbaua  
kirrumbaua@mymail.mapua.edu.ph

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Contract Address

The DegenToken smart contract is deployed on the Avalanche Fuji testnet at the following address:

`0x52d44078EB44dB92D7dA086c6E0D4B79329809b0`

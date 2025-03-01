require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require("@nomicfoundation/hardhat-ignition");
// require("hardhat-ignition");
require("dotenv").config(); // Load env variables

module.exports = {
  solidity: "0.8.28",
  networks: {
    amoy: {
      url: process.env.AMOY_RPC_URL, // Use RPC URL from .env
      accounts: [process.env.PRIVATE_KEY], // Load private key
    },
  },
  etherscan: {
    apiKey: {
      polygonAmoy: process.env.POLYGONSCAN_API_KEY, // Use Etherscan API key from .env
    },
  },
};
# PiggyBank Factory Contract

This is a smart contract that allows users to securely save funds in ERC-20 (USDC, USDT & DAI) tokens for a specified duration. Once the savings period is over, the owner can withdraw their funds. If withdrawn early, a 15% penalty is deducted and sent to the developer’s address.

To simplify deployment, we use a Factory Contract that allows users to create their own PiggyBank for different purposes) using CREATE2, making contract addresses predictable and efficient.

This contract was deployed and verified using hardhat ignition modules. It is available onchain at [AmoyPolygon Testnet](https://amoy.polygonscan.com/address/0x56751f7f7e9ad145de37599e7de0725b2215188d) 
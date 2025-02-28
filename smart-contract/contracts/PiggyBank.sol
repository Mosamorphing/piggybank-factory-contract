// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PiggyBank {
    address public owner;
    string public savingPurpose;
    uint256 public savingDuration;
    uint256 public creationTime;
    address public developerAddress; // where 15% of funds withdrawn before time goes to

    mapping(address => uint256) public balances;
    mapping(address => bool) public supportedTokens;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier isWithdrawn() {
        require(!withdrawn, "Funds have already been withdrawn");
        _;
    }

    bool public withdrawn;

    constructor(string memory _savingPurpose, uint256 _savingDuration, address _developerAddress) {
        owner = msg.sender;
        savingPurpose = _savingPurpose;
        savingDuration = _savingDuration;
        creationTime = block.timestamp;
        developerAddress = _developerAddress;
        supportedTokens[0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48] = true; // USDC
        supportedTokens[0x6B175474E89094C44Da98b954EedeAC495271d0F] = true; // DAI
        supportedTokens[0xdAC17F958D2ee523a2206206994597C13D831ec7] = true; // USDT
    }

    function deposit(address tokenAddress, uint256 amount) external {
        require(supportedTokens[tokenAddress], "Token not supported");
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

    function withdraw() external onlyOwner isWithdrawn {
        require(block.timestamp >= creationTime + savingDuration, "Funds cannot be withdrawn yet");
        withdrawn = true;
        _transferFunds();
    }

    function emergencyWithdraw(address tokenAddress) external onlyOwner isWithdrawn {
        require(supportedTokens[tokenAddress], "Token not supported");
        uint256 penalty = (balances[msg.sender] * 15) / 100;
        uint256 amountToWithdraw = balances[msg.sender] - penalty;

        // Transfer penalty to developer
        IERC20(tokenAddress).transfer(developerAddress, penalty);

        // Transfer remaining amount to owner
        IERC20(tokenAddress).transfer(msg.sender, amountToWithdraw);

        withdrawn = true;
    }

    function _transferFunds() private {
        address[] memory tokenAddresses = new address[](3);
        tokenAddresses[0] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; // USDC
        tokenAddresses[1] = 0x6B175474E89094C44Da98b954EedeAC495271d0F; // DAI
        tokenAddresses[2] = 0xdAC17F958D2ee523a2206206994597C13D831ec7; // USDT

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            address tokenAddress = tokenAddresses[i];
            uint256 balance = IERC20(tokenAddress).balanceOf(address(this));
            if (balance > 0) {
                IERC20(tokenAddress).transfer(owner, balance);
            }
        }
    }
}
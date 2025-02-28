// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./PiggyBank.sol";

contract PiggyBankFactory {
    address[] public piggyBanks;
    address public developerAddress;

    constructor(address _developerAddress) {
        developerAddress = _developerAddress;
    }

    function createPiggyBank(string memory _savingPurpose, uint256 _savingDuration, bytes32 salt) external returns (address) {
        // Use create2 to deploy a new PiggyBank contract
        PiggyBank newPiggyBank = new PiggyBank{salt: salt}(_savingPurpose, _savingDuration, developerAddress);
        piggyBanks.push(address(newPiggyBank));
        emit PiggyBankCreated(address(newPiggyBank), _savingPurpose);
        return address(newPiggyBank);
    }

    function getPiggyBanks() external view returns (address[] memory) {
        return piggyBanks;
    }

    event PiggyBankCreated(address indexed piggyBankAddress, string savingPurpose);
}
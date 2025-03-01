const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("DeployPiggyBankFactory", (m) => {
  const developerAddress = m.getParameter("developerAddress", "0x564268FbC519C6bD202C877f6fbc9F2068d3BF53");

  // Deploy PiggyBankFactory with the developer address
  const piggyBankFactory = m.contract("PiggyBankFactory", [developerAddress]);

  return { piggyBankFactory };
});

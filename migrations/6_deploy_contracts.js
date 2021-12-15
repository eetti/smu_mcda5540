var Warehouse = artifacts.require("Warehouse");
module.exports = function (deployer) {
    deployer.deploy(Warehouse, "Amazon", "0x344Fc7784B56280D087eB33dAbd97C2cA21886FF");
    // Additional contracts can be deployed here
};
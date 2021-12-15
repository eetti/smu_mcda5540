var Vendor = artifacts.require("Vendor");
module.exports = function (deployer) {
    deployer.deploy(Vendor, "Vendor1", "0x344Fc7784B56280D087eB33dAbd97C2cA21886FF");
    // Additional contracts can be deployed here
};
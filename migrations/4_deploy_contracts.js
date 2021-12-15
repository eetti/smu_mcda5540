var Vendor = artifacts.require("Vendor");
module.exports = function (deployer) {
    deployer.deploy(Vendor, "Vendor1");
    // Additional contracts can be deployed here
};
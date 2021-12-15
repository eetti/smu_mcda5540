var Asset = artifacts.require("Asset");
module.exports = function (deployer) {
    deployer.deploy(Asset, 1, "hello", "0x344Fc7784B56280D087eB33dAbd97C2cA21886FF");
    // Additional contracts can be deployed here
};
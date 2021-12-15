var Asset = artifacts.require("Asset");
module.exports = function (deployer) {
    deployer.deploy(Asset, "hello");
    // Additional contracts can be deployed here
};
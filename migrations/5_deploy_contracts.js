var AssetTracker = artifacts.require("AssetTracker");
module.exports = function (deployer) {
    deployer.deploy(AssetTracker);
    // Additional contracts can be deployed here
};
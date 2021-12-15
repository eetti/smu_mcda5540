var Customer = artifacts.require("Customer");
module.exports = function (deployer) {
    deployer.deploy(Customer, "Emma");
    // Additional contracts can be deployed here
};
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "./Asset.sol";
import "./Customer.sol";
import "./Vendor.sol";
import "./Warehouse.sol";

contract AssetTracker {
    //participants
    mapping(address => Warehouse) public warehouses;
    mapping(address => Customer) public customers;
    mapping(address => Vendor) public vendors;

    //asset
    mapping(int256 => Asset) public assets;
    int256 public assetId;

    //Events
    event AssetCreate(address account, int256 assetID, string customer);
    event AssetTransfer(address from, address to, int256 assetID);

    //create customer
    function createCustomer(string memory name, address cAddress) public {
        Customer customer = new Customer(name, cAddress);
        customers[cAddress] = customer;
    }

    //create vendor
    function createVendor(string memory name, address vAddress) public {
        Vendor vendor = new Vendor(name, vAddress);
        vendors[vAddress] = vendor;
    }

    //create vendor
    function createWarehouse(string memory name, address wAddress) public {
        Warehouse wh = new Warehouse(name, wAddress);
        warehouses[wAddress] = wh;
    }

    //Create Assets
    function createAsset(string memory assetName) public returns (int256) {
        //Only customers can create an asset
        if (msg.sender != customers[msg.sender].Address())
            revert("Only a customer can create an asset");
        bytes memory stringTest = bytes(assetName); // Uses memory
        if (stringTest.length == 0) revert("asset name must not be null");
        assetId = assetId + 1;
        Asset asset = new Asset(assetId, assetName, msg.sender);
        assets[assetId] = asset;

        emit AssetCreate(msg.sender, assetId, customers[msg.sender].Name());
        return assetId;
    }

    function getCurrentOwner(int256 assetID) public view returns (address) {
        Asset asset = assets[assetID];
        return asset.Owner();
    }

    // function getCustomerAdress(address adr) public view returns(address) {
    //          Customer customer = customers[adr];
    //          return customer.Address();
    // }

    function getCurrentState(int256 assetID)
        public
        view
        returns (string memory state)
    {
        Asset asset = assets[assetID];
        return asset.StateNames(uint256(asset.State()));
    }

    function getAsset(int256 assetID)
        public
        view
        returns (
            int256 id,
            string memory name,
            uint256 state,
            address owner
        )
    {
        Asset asset = assets[assetID];
        return (
            asset.AssetId(),
            asset.Name(),
            uint256(asset.State()),
            asset.Owner()
        );
    }

    function setAssetCurrentLocation(
        int256 assetID,
        string memory assetLocation
    ) public {
        //Transfer to Vemdor from Customer
        Asset asset = assets[assetID];
        asset.setAssetLocation(assetLocation);
    }

    function transferAsset(address to, int256 assetID) public {
        //check owner
        if (msg.sender != getCurrentOwner(assetID))
            revert("Only an owner can transfer an asset");

        //Transfer to Vendor from Customer
        Asset asset = assets[assetID];
        if (
            asset.State() == Asset.StateType.Created &&
            to == vendors[to].Address()
        ) {
            asset.setOwner(to);
            asset.setState(Asset.StateType.Vendor);
        }
        //Transfer to Warehouse from Vendor
        else if (
            asset.State() == Asset.StateType.Vendor &&
            to == warehouses[to].Address()
        ) {
            asset.setOwner(to);
            asset.setState(Asset.StateType.Warehouse);
        }
        //Transfer to Customer from Dealer
        else if (
            asset.State() == Asset.StateType.Warehouse &&
            to == customers[to].Address()
        ) {
            asset.setOwner(to);
            asset.setState(Asset.StateType.Shipped);
        }

        emit AssetTransfer(msg.sender, to, assetID);
    }
}

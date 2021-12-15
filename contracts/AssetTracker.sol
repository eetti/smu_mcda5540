// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "./Asset.sol";
import "./Customer.sol";
import "./Vendor.sol";
import "./Warehouse.sol";

contract AssetTracker {

    //participants
    mapping (address=>Warehouse) public warehouses;
    mapping (address=>Customer) public customers;
    mapping (address=>Vendor) public vendors;

    //asset
    mapping (int=>Asset) public assets;
    int public assetId;

    //Events
    event AssetCreate(address account, int assetID, string customer);
    event AssetTransfer(address from, address to, int assetID);

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
    function createAsset(string memory assetName) public returns (int)
    {
      //Only customers can create an asset
       if (msg.sender != customers[msg.sender].Address())
            revert("Only a customer can create an asset");
        assetId = assetId + 1;
        Asset asset =  new Asset(assetId, assetName, msg.sender);
        assets[assetId] = asset;
        
        emit AssetCreate (msg.sender, assetId, customers[msg.sender].Name());
        return assetId;
    }

    function getCurrentOwner(int assetID) public view returns(address) {
        Asset asset = assets[assetID];
        return asset.Owner();
    }

    function getManufacturerAdress(address adr) public view returns(address) {
             Customer customer = customers[adr];
             return customer.Address();
    }

    function getCurrentState(int assetID) public view returns(Asset.StateType) {
        Asset asset = assets[assetID];
        return asset.State();
    }

     function setAssetCurrentLocation(int assetID, string memory assetLocation) public 
    {
        //Transfer to Shipper from Manufacturer
        Asset asset = assets[assetID];
        asset.setAssetLocation(assetLocation);
    }

    function transferAsset(address to, int assetID) public 
    {
        //Transfer to Vendor from Customer
        Asset asset = assets[assetID];
        if(asset.State() == Asset.StateType.Created && to == vendors[to].Address())
        {
         //asset.setOwner(to);
         asset.setState(Asset.StateType.Inspected);
        }
        
        //Transfer to Warehouse from Vendor
        else  if(asset.State() == Asset.StateType.Inspected && to == warehouses[to].Address())
        {
            //asset.setOwner(to);
            asset.setState(Asset.StateType.Warehouse);
        }
        
        //Transfer to Customer from Dealer
        else  if(asset.State() == Asset.StateType.Warehouse && to == customers[to].Address())
        {
            //asset.setOwner(to);
            asset.setState(Asset.StateType.Shipped);
        }
       
        emit AssetTransfer (msg.sender, to, assetID);
    }
}
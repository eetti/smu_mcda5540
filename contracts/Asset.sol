// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Asset {

    enum StateType {
        Active, //0
        Created, //1
        Inspection, //2
        Inspected, //3
        Warehouse, //4
        Shipped, //5
        Accepted, //6
        Terminated //7
    }

    address public Owner;
    string public Name;
    StateType public State;
    string public AssetLocation;
    int public AssetId;

    event AssetCreated(string name, address owner);

    constructor(int assetId, string memory name, address owner) {
        AssetId = assetId;
        Owner = owner;
        State = StateType.Created;
        Name = name;
        emit AssetCreated(name, owner);
    }

    function setOwner(address assetOwner) public {
        Owner = assetOwner;
    }
    
    function setState(StateType assetState) public {
        State = assetState;
    }

    function setAssetLocation(string memory assetLocation) public {
        AssetLocation = assetLocation;
    }
}
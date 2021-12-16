// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Asset {
    enum StateType {
        Created, //0
        Vendor, //1
        Warehouse, //2
        Shipped //3
    }

    address public Owner;
    string public Name;
    StateType public State;
    string public AssetLocation;
    int256 public AssetId;

    mapping(uint256 => string) public StateNames;

    event AssetCreated(string name, address owner);

    constructor(
        int256 assetId,
        string memory name,
        address owner
    ) {
        AssetId = assetId;
        Owner = owner;
        State = StateType.Created;
        Name = name;
        StateNames[0] = "Created";
        StateNames[1] = "Vendor";
        StateNames[2] = "Warehouse";
        StateNames[3] = "Shipped";
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

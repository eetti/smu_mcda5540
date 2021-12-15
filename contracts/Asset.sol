// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Asset {
    enum StateType {
        Created, //1
        Vendor, //3
        Warehouse, //4
        Shipped //5
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
        StateNames[1] = "Created";
        StateNames[3] = "Vendor";
        StateNames[4] = "Warehouse";
        StateNames[5] = "Shipped";
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

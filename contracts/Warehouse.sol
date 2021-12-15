// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Warehouse {
    string public Name;
    address public Address;
    // mapping(uint => Item) items;

    constructor(string memory name,  address whAddress) {
        Name = name;
        Address = whAddress;
    }
}
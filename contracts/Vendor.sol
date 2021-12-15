// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Vendor {
    string public Name;
    address public Address;

    constructor(string memory name, address vendorAddress) {
        Name = name;
        Address = vendorAddress;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Customer {
    string public Name;
    address public Address;

    constructor(string memory name, address customerAddress) {
        Name = name;
        Address = customerAddress;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Test {
    uint256 public test = 100;

    function add(uint256 _x) external view returns (uint256) {
        return test + _x;
    }
}

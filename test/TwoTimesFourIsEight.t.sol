// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {TwoTimesFourIsEight} from "src/TwoTimesFourIsEight.sol";

contract TwoTimesFourIsEightTest is Test {
    TwoTimesFourIsEight greeter;

    function setUp() external {
        greeter = new TwoTimesFourIsEight();
    }

    function testSetGm() external {
        string memory name;
        name = greeter.name();
        console.log(name);
    }
}

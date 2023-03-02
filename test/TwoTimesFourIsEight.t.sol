// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {TwoTimesFourIsEight} from "src/TwoTimesFourIsEight.sol";

contract TwoTimesFourIsEightTest is Test {
    TwoTimesFourIsEight puzzle;
    address gen = 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed;
    uint256 seed;

    function setUp() external {
        puzzle = new TwoTimesFourIsEight();
        seed = puzzle.generate(gen);
    }

    function testSetGm() external {
        string memory name;
        name = puzzle.name();
        console.log(seed);
        console.log(puzzle.verify(seed, 0x1));
    }
}

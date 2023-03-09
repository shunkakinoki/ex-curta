// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {F1A9} from "src/F1A9.sol";

contract F1A9Test is Test {
    F1A9 puzzle;
    address gen = 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed;
    uint256 seed;

    function setUp() external {
        puzzle = new F1A9();
    }

    function test_deployed() external {
        vm.roll(16789503);
        seed = puzzle.generate(gen);
        console.log(block.number);
        console.log(seed);
    }

    function test_roll() external {
        for (uint256 i = 0; i < 300; i++) {
            vm.roll(16789335 + i);
            seed = puzzle.generate(gen);
            console.log(block.number);
            console.log(seed);
        }
    }
}

/// 580 * 12 = 6960
/// 6960 / 60 = 116
/// 1hr 56min
/// 19:15 + 1:56 = 21:11

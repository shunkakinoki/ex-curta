// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {F1A9, ISolve} from "src/F1A9.sol";
import {F1A9Gen} from "src/F1A9Gen.sol";
import {ICurta} from "src/ICurta.sol";

contract F1A9Test is Test {
    F1A9 puzzle;
    address gen = 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed;
    uint256 seed;

    function setUp() external {
        puzzle = new F1A9();
    }

    function test_deployed() external {
        vm.roll(16792640);
        seed = puzzle.generate(gen);
        console.log(block.number);
        console.log(seed);
    }

    function test_roll() external {
        for (uint256 i = 0; i < 10000; i++) {
            vm.roll(16792640 + i);
            seed = puzzle.generate(gen);
            console.log(block.number);
            console.log(seed);
        }
    }

    function test_verify() external {
        string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
        uint256 mainnetFork = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnetFork);
        vm.startPrank(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);
        puzzle = F1A9(0x9f00c43700bc0000Ff91bE00841F8e04c0495000);
        seed = puzzle.generate(gen);

        F1A9Gen genz = F1A9Gen(0x73D010a92e83495cb596Debc9BDE74f95A458feB);
        uint256 seedz = genz.generate(gen);
        seedz = genz.verify(seedz);

        puzzle.verify(
            seed,
            uint256(uint160(0xF1A96d654114ce69B7680B32a01A46BC0d3d7f02))
        );

        ISolve solve = ISolve(0xF1A96d654114ce69B7680B32a01A46BC0d3d7f02);
        assertEq(solve.curtaPlayer(), msg.sender);

        ICurta curta = ICurta(0x0000000006bC8D9e5e9d436217B88De704a9F307);
        curta.solve(
            2,
            uint256(uint160(0xF1A96d654114ce69B7680B32a01A46BC0d3d7f02))
        );
    }
}

/// 580 * 12 = 6960
/// 6960 / 60 = 116
/// 1hr 56min
/// 19:15 + 1:56 = 21:11

/// 0xF1A96d654114ce69B7680B32a01A46BC0d3d7f02
/// 0xf1a96d65
/// 0xf1a96d65

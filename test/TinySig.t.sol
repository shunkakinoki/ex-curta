// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {TinySig, Deployer} from "src/TinySig.sol";

contract F1A9Test is Test {
    TinySig puzzle;
    Deployer deployer;
    address gen = 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed;
    uint256 seed;

    function setUp() external {
        puzzle = new TinySig();
        seed = puzzle.generate(gen);
        console.log(seed);
    }

    function test_deployed() external {
        bytes32 sh = bytes32(uint256(1));
        uint8 sv = uint8(27);
        bytes32 sr = bytes32(uint256(3));

        bytes memory params = abi.encode(sh, sv, sr);

        address target = address(
            new Deployer(hex"6001600052601b602052600360405260606000F3")
        );
        (, bytes memory ret) = target.staticcall("");

        (bytes32 h, uint8 v, bytes32 r) = abi.decode(
            ret,
            (bytes32, uint8, bytes32)
        );

        assertEq(h, sh);
        assertEq(v, sv);
        assertEq(r, sr);
    }
}

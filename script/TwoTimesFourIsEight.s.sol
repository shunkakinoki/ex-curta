// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {IPuzzle} from "src/IPuzzle.sol";

/// @notice A very simple deployment script
contract TwoTimesFourIsEightScript is Script {
    /// @notice The main script entrypoint
    function run() public view {
        IPuzzle puzzle = IPuzzle(0x00000000eCf2b58C296B47caC8C51467c0e307cE);
        console.log(puzzle.name());
    }
}

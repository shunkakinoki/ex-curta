// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {Tinysolve} from "src/TinySigSolve.sol";
import "forge-std/console.sol";
import {ICurta} from "src/ICurta.sol";
import {IPuzzle} from "src/IPuzzle.sol";

/// @notice A very simple deployment script
contract TinySigScript is Script {
    function run() external {
        vm.startBroadcast();
        Tinysolve sol = Tinysolve(0x000000000045E5418329Ee1F6D07Dc6E73ad0AB0);
        (, bytes memory ret) = address(sol).staticcall("");

        console.logBytes(ret);
        (bytes32 h, uint8 v, bytes32 r) = abi.decode(
            ret,
            (bytes32, uint8, bytes32)
        );
    }
}

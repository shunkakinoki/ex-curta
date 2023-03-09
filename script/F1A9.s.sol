// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {F1A9Sol} from "src/F1A9Sol.sol";
import "forge-std/console.sol";
import {ICurta} from "src/ICurta.sol";
import {IPuzzle} from "src/IPuzzle.sol";

/// @notice A very simple deployment script
contract F1A9Script is Script {
    function run() external {
        vm.startBroadcast();
        bytes32 salt = 0x0fe13f1eaac766c3bcd13db0eee51b4ac34f01ad17cbf746fb756f3fe2c842e4;
        // uint256 salt = 4286601748635615094232218652219162031844775069769918281771736215745878049444;
        // F1A9Sol Sol = new F1A9Sol{salt: bytes32(salt)}();
        F1A9Sol Sol = new F1A9Sol{salt: bytes32(salt)}();
    }
}

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
        bytes32 salt = 0xc63790430ceb6464a312e8d6a4abd40c4331216454ed8c835d284082c9490c70;
        F1A9Sol Sol = new F1A9Sol{salt: salt}();
    }
}

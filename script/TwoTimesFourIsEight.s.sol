// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {ICurta} from "src/ICurta.sol";
import {IPuzzle} from "src/IPuzzle.sol";

/// @notice A very simple deployment script
contract TwoTimesFourIsEightScript is Script {
    /// @notice The main script entrypoint
    function run() external {
        ICurta curta = ICurta(0x00000000eCf2b58C296B47caC8C51467c0e307cE);
        console.log(curta.name());
        (
            IPuzzle puzzle,
            uint40 addedTimestamp,
            uint40 firstSolveTimestamp
        ) = curta.getPuzzle(1);
        console.log(puzzle.name());
        console.log(
            puzzle.generate(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed)
        );
    }
}

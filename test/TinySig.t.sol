// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Tinysolve} from "src/TinySigSolve.sol";
import {ICurta} from "src/ICurta.sol";
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

    // function test_fork() external {
    //     string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
    //     uint256 mainnetFork = vm.createSelectFork(MAINNET_RPC_URL);
    //     ICurta curta = ICurta(0x0000000006bC8D9e5e9d436217B88De704a9F307);

    // vm.rollFork(16856853);
    // vm.prank(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);
    // curta.solve(
    //     3,
    //     0x6000808080806ea4c4466c164f2cc5b89a3f835803385afa3d82803e3d82f300
    // );

    // vm.rollFork(16858288);
    // vm.prank(0x9470Ab9c3aAc221A57e94F522659D4327C5EAdEd);
    // curta.solve(
    //     3,
    //     0x6000808080806fe6a8a13661698812936404a40d9bfdce5afa3d82803e3d82f3
    // );

    // vm.rollFork(16859843);
    // vm.prank(0x03433830468d771A921314D75b9A1DeA53C165d7);
    // curta.solve(
    //     3,
    //     0x586060808280806e45e5418329ee1f6d07dc6e73ad0ab05afa5090f300000000
    // );

    // vm.rollFork(16856853);
    // vm.prank(0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed);
    // curta.solve(
    //     3,
    //     0x6000808080806ea4c4466c164f2cc5b89a3f835803385afa3d82803e3d82f300
    // );
    // }

    // Tinysolve solve = Tinysolve(0x000000000045E5418329Ee1F6D07Dc6E73ad0AB0);
    // solve.setHash(
    //     0x50d335e3542486d95d8ac86296c534d4ce2e70421bdc54bd18d758cff0614453
    // );

    //     puzzle.verify(
    //         seed,
    //         0x586060808280806e45e5418329ee1f6d07dc6e73ad0ab05afa5090f300000000
    //     );
    // }

    function test_ecrecover() external {
        address a = ecrecover(
            0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8,
            27,
            0x433ec3d37e4f1253df15e2dea412fed8e915737730f74b3dfb1353268f932ef5,
            0x557c9158e0b34bce39de28d11797b42e9b1acb2749230885fe075aedc3e491a4
        );
        assertEq(a, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);

        // address a = ecrecover(
        //     0x5fe7f977e71dba2ea1a68e21057beebb9be2ac30c6410aa38d4f3fbe41dcffd2,
        //     28,
        //     0x00000000000000000000003b78ce563f89a0ed9414f5aa28ad0d96d6795f9c63,
        //     0x30c5558ed776df23ee6d687211929e61e2cde407f8c32fb2ab9a429fae20409c
        // );
    }

    // function test_deployed() external {
    //     bytes32 sh = bytes32(uint256(1));
    //     uint8 sv = uint8(27);
    //     bytes32 sr = bytes32(uint256(3));

    //     bytes memory params = abi.encode(sh, sv, sr);

    //     address target = address(
    //         new Deployer(
    //             hex"586060808280806e45e5418329ee1f6d07dc6e73ad0ab05afa5090f300000000"
    //         )
    //     );
    //     (, bytes memory ret) = target.staticcall("");

    //     (bytes32 h, uint8 v, bytes32 r) = abi.decode(
    //         ret,
    //         (bytes32, uint8, bytes32)
    //     );

    //     assertEq(h, sh);
    //     assertEq(v, sv);
    //     assertEq(r, sr);
    // }
}

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

    //     vm.rollFork(16856853 - 1);
    //     vm.prank(0x4a69B81A2cBEb3581C61d5087484fBda2Ed39605);
    //     curta.solve(
    //         3,
    //         0x6000808080806ea4c4466c164f2cc5b89a3f835803385afa3d82803e3d82f300
    //     );

    //     vm.rollFork(16857971 - 1);
    //     vm.prank(0x0165f91FAF9EDeb9C5817c7a3c92110aa5329BeA);
    //     curta.solve(
    //         3,
    //         0x6000808080806f2568597ac16f21c85ca26644e46624dc5afa3d82803e3d82f3
    //     );

    //     vm.rollFork(16858289 - 1);
    //     vm.prank(0x9470Ab9c3aAc221A57e94F522659D4327C5EAdEd);
    //     curta.solve(
    //         3,
    //         0x6000808080806fe6a8a13661698812936404a40d9bfdce5afa3d82803e3d82f3
    //     );
    // }

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
        address solver = ecrecover(
            0xa8bc76c25f74643efddbb117219f6d9e5eede07e732ee5ea163c5199b41e5804,
            28,
            0x00000000000000000000003b78ce563f89a0ed9414f5aa28ad0d96d6795f9c63,
            0xae87127b4117378204489d5acb247841a4401da84e482051f910ec39457099b4
        );
        assertEq(solver, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);

        address a = ecrecover(
            0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8,
            27,
            0x433ec3d37e4f1253df15e2dea412fed8e915737730f74b3dfb1353268f932ef5,
            0x557c9158e0b34bce39de28d11797b42e9b1acb2749230885fe075aedc3e491a4
        );
        assertEq(a, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);

        address t = ecrecover(
            0x2750c90065ce5155632f83abd2a5272679a670d415050275105659297ca8463f,
            28,
            0x84e7465d2f4fb433c4c09eef86ec95bd28e36fef808f91e6185f269890bc5a38,
            0xcfc6278c91e41313cf2c0ac5562cfcc7ba30255c24f48c3e17d5dfaeb1dbce03
        );
        assertEq(t, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);

        address br = ecrecover(
            0x47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad,
            27,
            0xc6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5,
            0x868dd90cf56258c5c76e381a8674702eaa3d439d67ca948357b401ef54905f49
        );
        assertEq(br, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);

        address b = ecrecover(
            0xe79d55389444906e08c94b8b7e685a8e3fa6fd4e9df15e39bcf7a6667fc68490,
            28,
            0x00000000000000000000003b78ce563f89a0ed9414f5aa28ad0d96d6795f9c63,
            0x30c5558ed776df23ee6d687211929e61e2cde407f8c32fb2ab9a429fae20409c
        );
        assertEq(b, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf);
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

// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

import "./IPuzzle.sol";

/// @title 2 × 4 = 8
/// @author fiveoutofnine
contract TwoTimesFourIsEight is IPuzzle {
    uint256 private constant CURTA =
        0x400010005000000040001000500000004000100050000000422232227;

    uint256 private constant WATERFALL = 0x104104104104;

    uint256 private constant PRICING = 0x820820820820;

    uint256 private constant SHANEFANX = 0x104104504104;

    uint256 private constant FIVEOUTOFNINE = 0x1FE;

    /// @inheritdoc IPuzzle
    function name() external pure returns (string memory) {
        return unicode"2 × 4 = 8";
    }

    /// @inheritdoc IPuzzle
    function generate(address _seed) external pure returns (uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(_seed)));
        uint256 puzzle;

        uint256 nineoutoffive = 1 << 64;
        uint256 j = 64;
        for (uint256 i = 1; i < 9; ) {
            if (seed == 0) break;

            while ((nineoutoffive >> j) & 1 == 1 && seed != 0) {
                j = seed & 0x3F;
                seed >>= 6;
            }
            nineoutoffive |= 1 << j;

            puzzle |= (i << (j << 2));
            j = 64;
            unchecked {
                ++i;
            }
        }

        return puzzle;
    }

    /// @inheritdoc IPuzzle
    function verify(uint256 _start, uint256 _solution)
        external
        pure
        returns (bool)
    {
        for (uint256 i; i < 256; ) {
            if (_start & 0xF != 0 && _start & 0xF != _solution & 0xF)
                return false;

            uint256 followUs = (CURTA >> i) & 7;
            if (followUs & 4 == 4 && !h(_solution, WATERFALL)) return false;
            if (followUs & 2 == 2 && !h(_solution, PRICING)) return false;
            if (followUs & 1 == 1 && !h(_solution, SHANEFANX)) return false;

            _start >>= 4;
            _solution >>= 4;
            unchecked {
                i += 4;
            }
        }

        return true;
    }

    function h(uint256 _shanexm, uint256 _gitswitch)
        internal
        pure
        returns (bool)
    {
        uint256 shanefanx = _shanexm;
        uint256 fiveoutofnine;

        while (_gitswitch != 0) {
            fiveoutofnine |= 1 << (shanefanx & 0xF);
            shanefanx >>= (_gitswitch & 0x3F);
            _gitswitch >>= 6;
        }

        return fiveoutofnine == FIVEOUTOFNINE;
    }
}

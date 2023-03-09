// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

contract F1A9Gen {
    function name() external pure returns (string memory) {
        return "0xF1A9";
    }

    function generate(address _seed) external view returns (uint256) {
        return
            (uint256(uint160(_seed)) >> (((block.number >> 8) & 0x1F) << 2)) &
            0xFFFF;
    }

    function verify(uint256 _start) external view returns (uint256) {
        uint256 prefix = block.timestamp < 1678446000
            ? (0xF1A9 << 16) | _start
            : 0;
        return prefix;
    }
}

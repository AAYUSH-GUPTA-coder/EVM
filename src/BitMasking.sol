// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EVMStoragePackedSlotBytes {
    // slot 0 (Packed right to left)
    // 0x000000....00000000
    // 0x000000....abababab
    bytes4 public b4 = 0xabababab;
    // 0x00....cacdabababab
    bytes2 public b2 = 0xcacd;

    function get() public view returns (bytes32 b32) {
        assembly {
            b32 := sload(0)
        }
    }
}

contract BitMasking {
    // |            256 bits        |
    // 000 ...      000 | 111 ... 111
    function test_mask() public pure returns (bytes32 mask) {
        assembly {
            // initial value, 1 in 16th index
            // 000 ... 001 | 000 ... 000
            // final value, 0 to 15th index 1 and rest 0
            // 000 ... 000 | 111 ... 111

            // shl = shift left
            // sub = sub
            mask := sub(shl(16, 1), 1)
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
            // 1 hex = 4 bits
            // so ffff = 16 bits
        }
    }

    // 000 ... 000 | 111 ... 111 | 000 ... 000
    //             | 16 bits     | 32 bits
    function test_shift_mask() public pure returns (bytes32 mask) {
        assembly {
            mask := shl(32, sub(shl(16, 1), 1))
            // 0x0000000000000000000000000000000000000000000000000000ffff00000000
        }
    }

    // 111 ... 111 | 000 ... 000 | 111 ... 111
    //             | 16 bits     | 32 bits
    function test_not_mask() public pure returns (bytes32 mask) {
        assembly {
            mask := not(shl(32, sub(shl(16, 1), 1)))
        }
    }
}

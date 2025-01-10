// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract EVMStoragePackedSlot {
    // Data < 32 bytes are packed into a slot
    // Bit masking (how to create 111...111)
    // slot, offset

    // slot 0
    uint128 public s_a; // 16 bytes
    uint64 public s_b; // 8 bytes
    uint32 public s_c; // 4 bytes
    uint32 public s_d; // 4 bytes

    // slot 1
    // 20 bytes = 160 bits
    address public s_addr;
    // 8 bytes = 64 bits
    uint64 public s_x;
    // 4 bytes = 32 bits
    uint32 public s_y;

    function test_sstore() public {
        assembly {
            let v := sload(0)

            // s_d | s_c | s_b | s_a
            // 32  | 32  | 64  | 128 bits
            // 4   |  4  |  8  | 16  bytes

            // Set s_a = 11
            // 111 ... 111 | 000 ... 000
            //             | 128 bits
            let mask_a := not(sub(shl(128, 1), 1))
            
            v := and(v, mask_a)

        }
    }
}

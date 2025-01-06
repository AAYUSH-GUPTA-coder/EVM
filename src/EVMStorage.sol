// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Yul syntax
// EVM Storage
contract YulIntro {
    // Yul - Language used for inline assembly in solidity
    // Yul variable assignment
    // Yul types [everything is a bytes32]
    function test_yul_var() public pure returns (uint256) {
        uint256 s = 0;

        assembly {
            // Yul variable assignment
            let x := 1
            // Yul variable re-assignment
            x := 2
            s := 2
        }

        return s;
    }

    // Yul types (everything is bytes32)
    function test_yul_types() public pure returns (bool x, uint256 y, bytes32 z) {
        assembly {
            x := 1
            y := 0xaa
            z := "Hello Yul"
        }
    }
}

contract EVMStorageSingleSlot {
    // EVM Storage
    // 2**256 slots, each slot can store upto 32 bytes
    // Slots are assigned in the order the state variables are decleared
    // Data less than 32 bytes are packed into a single slot ( right to left )
    // sstore(k,v) = store v to slot k
    // sload(k) = load 32 bytes from slot k

    // Single variable stored in one slot
    uint256 public s_x; // slot 0
    uint256 public s_y; // slot 1
    bytes32 public s_z; // slot 2

    function test_sstore() public {
        assembly {
            sstore(0, 111)
            sstore(1, 222)
            sstore(2, 0xababab)
        }
    }

    function test_sstore_again() public {
        assembly {
            sstore(s_x.slot, 122)
            sstore(s_y.slot, 2979)
            sstore(s_z.slot, 0xdaaa)
        }
    }

    function test_sload() public view returns (uint256 x, uint256 y, bytes32 z) {
        assembly {
            x := sload(0)
            y := sload(1)
            z := sload(2)
        }
    }

    function test_sload_again() public view returns (uint256 x, uint256 y, bytes32 z) {
        assembly {
            x := sload(s_x.slot)
            y := sload(s_y.slot)
            z := sload(s_z.slot)
        }
    }
}

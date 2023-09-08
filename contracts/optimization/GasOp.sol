// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

// Gas - 60700
// Opt:
//  1. use calldata
//  2. state variable to emmory
//  3. short circuit
//  4. ++i
//  5. load array elements to memory
//  6. cache array length
contract GasOp {
    uint private total;

    function getTotal() external view returns (uint) {
        return total;
    }

    // Test data: [1, 3, 4, 5, 10, 21, 33, 100]
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;
        for (uint i = 0; i < len; ++i) {
            uint num = nums[i];
            if (num % 2 == 0 && num < 99) {
                _total += num;
            }
        }

        total = _total;
    }
}
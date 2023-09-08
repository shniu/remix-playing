// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract EncodeAndDecode {

    struct Price {
        string symbol;
        uint[2] sidePrice; 
    }

    function encode(
        uint x, address addr, uint[] calldata arr, Price calldata p
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, p);
    }

    function decode(bytes calldata data) external pure 
      returns (
          uint x, 
          address addr, 
          uint[] memory arr, 
          Price memory p
    ) {
        (x, addr, arr, p) = abi.decode(data, (uint, address, uint[], Price));
    }

}
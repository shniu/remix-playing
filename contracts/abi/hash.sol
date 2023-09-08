// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract HashFunc {
    function hash(
        string memory _text, uint _num, address _addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    function methodSignature(
        string memory func
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(func));
    }

    function methodSelector(
        string memory _func
    ) external pure returns (bytes4) {
        // return keccak256(abi.encodePacked(func));
        return bytes4(keccak256(bytes(_func)));
    }

    function encode(
        string memory _text1, string memory _text2
    ) external pure returns (bytes memory) {
        return abi.encode(_text1, _text2);
    }

    function encodePacked(
        string memory _text1, string memory _text2
    ) external pure returns (bytes memory) {
        return abi.encodePacked(_text1, _text2);
    }
    
}
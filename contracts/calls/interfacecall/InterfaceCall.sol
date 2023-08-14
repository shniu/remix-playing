// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
    function dec() external;
}

contract InterfaceCall {
    uint public count;

    function doCall(address _counterAddr) external {
        ICounter(_counterAddr).inc();
        count = ICounter(_counterAddr).count();
    }
}
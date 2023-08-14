// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import "./EthHolder.sol";

contract DirectlyCall {
    function proxySetState(address _addr, uint256 _s) external payable {
        EthHolder(_addr).setStateAndSendEth{ value: msg.value }(_s);
    }

    function proxyGetState(address _addr) view external returns (uint s) {
        s = EthHolder(_addr).getState();
    }
}
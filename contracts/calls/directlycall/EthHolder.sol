// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract EthHolder {
    uint256 private state;

    mapping(address => uint256) _balances;

    event Log(uint amount, uint gas);

    event TriggerFallback(address sender, uint value);

    receive() external payable {
        receiveEth();
    }

    fallback() external payable {
        receiveEth();
    }

    function receiveEth() internal {
        _balances[msg.sender] += msg.value;
        emit TriggerFallback(msg.sender, msg.value);
    }

    function getEthBalance(address _addr) external view returns (uint256 value) {
        value = _balances[_addr];
    }

    function getBalance() view public returns (uint) {
        return address(this).balance;
    }

    function setStateAndSendEth(uint256 _s) external payable {
        state = _s;

        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    function getState() external view returns (uint s) {
        s = state;
    }
}

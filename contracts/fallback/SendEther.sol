// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract SendEther {
    event LogSend(uint amount, uint gas);

    constructor() payable { }

    // 合约接收主币
    receive() external payable { }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function sendViaTransfer(address payable _to) external payable {
        emit LogSend(123, gasleft());

        _to.transfer(123);
        emit LogSend(123, gasleft());
    }

    function sendViaSend(address payable _to) external payable {
        emit LogSend(123, gasleft());

        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        emit LogSend(123, gasleft());

        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
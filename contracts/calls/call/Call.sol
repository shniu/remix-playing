// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract Call {
    event Response(bool success, bytes data);

    function proxyDoCall(address payable _addr, uint256 _s) external payable {
        (bool success, bytes memory data) = _addr.call{ value: msg.value }(
            abi.encodeWithSignature("setStateAndSendEth(uint256)", _s)
        );

        emit Response(success, data);
    }

    function proxyOtherCall(address _addr) external payable {
        require(_addr != address(0), "bad address");
        (bool success, bytes memory data) = _addr.call{ value: msg.value }(abi.encodeWithSignature("someMethod(uint256)"));
        emit Response(success, data);
    }
}
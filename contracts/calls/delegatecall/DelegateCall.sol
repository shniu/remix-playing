// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract Target {
    uint256 public state;
    mapping(address => uint256) private _balances;

    event Receive(address sender, uint256 value);

    function updateState(uint256 _s) external payable {
        state = _s;

        if (msg.value > 0) {
            _balances[msg.sender] += msg.value;
        }

        emit Receive(msg.sender, msg.value);
    }

    function getBalance(address _addr) view external returns (uint256) {
        require(_addr != address(0), "bad address");
        return _balances[_addr];
    }
}

contract DelegateCall {

    uint256 public state;
    mapping(address => uint256) private _balances;

    function updateState(address _addr, uint256 _s) external payable {
        (bool success, ) = _addr.delegatecall(abi.encodeWithSignature("updateState(uint256)", _s));
        require(success, "bad call");
    }

    function getBalance(address _addr) view external returns (uint256) {
        require(_addr != address(0), "bad address");
        return _balances[_addr];
    }

}
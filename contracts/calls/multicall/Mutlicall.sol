// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract Erc20 {

    mapping(address => uint256) private _balances;
    string private symbol;

    event Transfer(address from, address to, uint256 amount);

    constructor(string memory symbol_) {
        symbol = symbol_;
    }

    function balanceOf(address _addr) view external returns (uint256, uint) {
        return (_balances[_addr], block.timestamp);
    }

    function transfer(address _addr, uint256 amount) external {
        _balances[_addr] += amount;
        emit Transfer(msg.sender, _addr, amount);
    }

    function getInputData(address _addr) external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.balanceOf.selector, _addr);
    }
}

contract Multicall {

    function doCall(address[] calldata targets, bytes[] calldata data) external view returns (bytes[] memory) {
        require(targets.length == data.length, "arg length not match");
        bytes[] memory results = new bytes[](data.length);

        for (uint i = 0; i < data.length; i++) {
            (bool success, bytes memory r) = targets[i].staticcall(data[i]); 
            require(success, "bad call");
            results[i] = r;
        }

        return results;
    }

}
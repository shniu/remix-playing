// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// contract Enum {
//     // Enum representing shipping status
//     enum Status {
//         Pending,
//         Shipped,
//         Accepted,
//         Rejected,
//         Canceled
//     }

//     // Default value is the first element listed in
//     // definition of the type, in this case "Pending"
//     Status public status;

//     // Returns uint
//     // Pending  - 0
//     // Shipped  - 1
//     // Accepted - 2
//     // Rejected - 3
//     // Canceled - 4
//     function get() public view returns (Status) {
//         return status;
//     }

//     // Update status by passing uint into input
//     function set(Status _status) public {
//         status = _status;
//     }

//     // You can update to a specific enum like this
//     function cancel() public {
//         status = Status.Canceled;
//     }

//     // delete resets the enum to its first value, 0
//     function reset() public {
//         delete status;
//     }

//     function selector() public returns (string memory) {
//         return get.selector;
//     }
// }

interface IERC20Token {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @dev send `value` token to `to` from `msg.sender`
    /// @param to The address of the recipient
    /// @param value The amount of token to be transferred
    /// @return True if transfer was successful
    function transfer(address to, uint256 value) external returns (bool);

    /// @dev send `value` token to `to` from `from` on the condition it is approved by `from`
    /// @param from The address of the sender
    /// @param to The address of the recipient
    /// @param value The amount of token to be transferred
    /// @return True if transfer was successful
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    /// @dev `msg.sender` approves `spender` to spend `value` tokens
    /// @param spender The address of the account able to transfer the tokens
    /// @param value The amount of wei to be approved for transfer
    /// @return Always true if the call has enough gas to complete execution
    function approve(address spender, uint256 value) external returns (bool);

    /// @dev Query total supply of token
    /// @return Total supply of token
    function totalSupply() external view returns (uint256);

    /// @dev Get the balance of `owner`.
    /// @param owner The address from which the balance will be retrieved
    /// @return Balance of owner
    function balanceOf(address owner) external view returns (uint256);

    /// @dev Get the allowance for `spender` to spend from `owner`.
    /// @param owner The address of the account owning tokens
    /// @param spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address owner, address spender) external view returns (uint256);

    /// @dev Get the number of decimals this token has.
    function decimals() external view returns (uint8);
}

contract Test20 {

    function sellToPancakeSwap(
        IERC20Token[] calldata tokens,
        uint256 sellAmount,
        uint256 minBuyAmount
    ) external payable returns (uint256 buyAmount) {
        require(tokens.length > 1, "");
        require(sellAmount > 0, "");
        require(minBuyAmount > 0, "");
        return 0;
    }

    struct Transformation {
        // The deployment nonce for the transformer.
        // The address of the transformer contract will be derived from this
        // value.
        uint32 deploymentNonce;
        // Arbitrary data to pass to the transformer.
        bytes data;
    }

    function transformERC20(
        IERC20Token inputToken,
        IERC20Token outputToken,
        uint256 inputTokenAmount,
        uint256 minOutputTokenAmount,
        Transformation[] calldata transformations
    ) external payable returns (uint256 outputTokenAmount) {
        require(address(inputToken) != address(0), "");
        require(address(outputToken) != address(0), "");
        require(inputTokenAmount > 0, "");
        require(minOutputTokenAmount > 0, "");
        require(transformations.length > 0, "");
        return 0;
    }

    function getTransformERC20Selector() external pure returns (bytes4) {
        return this.transformERC20.selector;
    }
}

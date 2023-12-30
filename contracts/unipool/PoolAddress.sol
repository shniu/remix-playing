// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract PoolAddress {
    bytes32 internal constant POOL_INIT_CODE_HASH = 0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;

    struct PoolKey {
        address token0;
        address token1;
        uint24 fee;
    }

    function getPoolKey(
        address tokenA,
        address tokenB,
        uint24 fee
    ) public pure returns (PoolKey memory) {
        if (tokenA > tokenB) (tokenA, tokenB) = (tokenB, tokenA);
        return PoolKey({token0: tokenA, token1: tokenB, fee: fee});
    }

    function encodePoolKey(
        address tokenA,
        address tokenB,
        uint24 fee
    ) public pure returns (bytes memory result) {
        PoolKey memory key = getPoolKey(tokenA, tokenB, fee);
        result = abi.encode(key.token0, key.token1, key.fee);
    }

    function keccak256PoolKey(
        address tokenA,
        address tokenB,
        uint24 fee
    ) public pure returns (bytes32 result) {
        result = keccak256(encodePoolKey(tokenA, tokenB, fee));
    }

    function encodePackedPoolKey(
        address factory, 
        address tokenA,
        address tokenB,
        uint24 fee
    ) public pure returns (bytes memory result) {
        bytes32 pk = keccak256PoolKey(tokenA, tokenB, fee);
        result = abi.encodePacked(
                        hex'ff',
                        factory,
                        pk,
                        POOL_INIT_CODE_HASH
                    );
    }

    function keccak256EncodePackedPoolKey(
        address factory, 
        address tokenA,
        address tokenB,
        uint24 fee
    ) public pure returns (bytes32 result) {
        result = keccak256(encodePackedPoolKey(factory, tokenA, tokenB, fee));
    }

    function computeAddress(address factory, PoolKey memory key) external returns (address) {
        require(key.token0 < key.token1);

        bytes32 k = keccak256EncodePackedPoolKey(factory, key.token0, key.token1, key.fee);

        // uint256 poolAddress = uint256(
        //         keccak256(
        //             abi.encodePacked(
        //                 hex'ff',
        //                 factory,
        //                 keccak256(abi.encode(key.token0, key.token1, key.fee)),
        //                 POOL_INIT_CODE_HASH
        //             )
        //         )
        //     );
        uint256 poolAddress = uint256(k);
        uint160 pa160 = uint160(poolAddress);
        
        address pool = address(pa160);

        emit K1(poolAddress, pa160, pool);

        return pool;
    }

    event K1 (uint256 indexed paUint256, uint160 indexed paUint160, address indexed pa);
}

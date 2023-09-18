// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

contract VerifySignature {

    function verify(address _signer, string memory _message, bytes memory _signature)
      external pure returns (bool) {
          bytes32 messageHash = getMessageHash(_message);
          bytes32 signedMessageHash = getSignedMessageHash(messageHash);

          return recover(signedMessageHash, _signature) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getSignedEncodePacked(string memory _message) public pure returns (bytes memory) {
        bytes32 _messageHash = getMessageHash(_message);
        return abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash);
    }

    function getSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        bytes memory p = abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash);
        return keccak256(p);
    }

    function recover(bytes32 _signedMessageHash, bytes memory _signature) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_signedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory _signature) private pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_signature.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96)))
        }
    }
}
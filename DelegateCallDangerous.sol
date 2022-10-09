/* 

    @notice - This contract is vulnerable to delegatecall attack
    THIS IS FOR EDUCATIONAL PURPOSES ONLY
    DO NOT USE THIS CODE IN PRODUCTION

    Check DelegateCallProtection.sol for a protected version of this contract


*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract DelegateCallDangerous {

    address private owner;

    constructor() payable {
        require(msg.value == 10 ether);
        owner = msg.sender;
    }

    // ----------------- DELEGATECALL FUNCTION -----------------

    function delegateFunction(address delegate, bytes memory args) external {
        (bool sent, ) = delegate.delegatecall(args);
        require(sent, "Failed to delegate call");
    }

    // ----------------- WITHDRAW FUNCTION -----------------

    function withdraw() external {
        require(msg.sender == owner, "!OWNER");
        payable(msg.sender).transfer(address(this).balance);
    }

    // ----------------- VIEW FUNCTION -----------------

    function getContractBalance() external view returns(uint256) {
        return address(this).balance;
    }

}


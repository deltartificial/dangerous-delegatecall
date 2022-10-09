/* 


    THIS IS FOR EDUCATIONAL PURPOSES ONLY
    DO NOT USE THIS CODE IN PRODUCTION


*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract DelegateCallProtected {

    // @notice - Withdraw function is protected because owner variable is immutable
    address immutable owner;

    constructor() payable {
        require(msg.value == 10 ether);
        owner = msg.sender;
    }

    // ----------------- DELEGATECALL FUNCTION -----------------

    function delegateFunction(address delegate, bytes memory args) external {

        // @notice - You can add a check here to make sure that the delegate is the owner
        // require(msg.sender == owner, "!OWNER"); 

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
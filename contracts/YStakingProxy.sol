// SPDX-License-Identifier: SSPL-1.0

/// @title YBearBull Staking Contract Proxy

pragma solidity >=0.6.4 <0.8.0;

import "./Ownable.sol";

contract YStakingProxy is Owned {
    address payable public feeRecipient;

    // FIXME Linter: Code contains empty blocks [no-empty-blocks]
    receive() external payable {}

    // FIXME Linter: Provide an error message for require [reason-string]
    function forwardfees() public {
        require(feeRecipient != address(0));
        feeRecipient.transfer(address(this).balance);
    }

    function setFeeRecipient(address payable account) public onlyOwner() {
        feeRecipient = account;
    }
}

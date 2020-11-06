// SPDX-License-Identifier: SSPL-1.0

/// @title Vault Helper Interface Contract

pragma solidity >=0.6.4 <0.8.0;

import "./Ownable.sol";
import "./Interfaces/VaultHelperInterface.sol";

contract VaultHelperProxy is Owned {
    VaultHelperInterface public vaultHelper;
    address public vaultHelperPropose;

    function getBonus(
        address vault,
        address token,
        uint256 eth
    ) public view virtual returns (uint256) {
        return (vaultHelper.getBonus(vault, token, eth));
    }

    function getPenalty(
        address vault,
        address token,
        uint256 eth
    ) public view virtual returns (uint256) {
        return (vaultHelper.getPenalty(vault, token, eth));
    }

    function getSharePrice(address vault) public view virtual returns (uint256) {
        return (vaultHelper.getSharePrice(vault));
    }

    function getLiqAddTokens(address vault, uint256 eth)
        public
        view
        virtual
        returns (
            uint256 bullEquity,
            uint256 bearEquity,
            uint256 bullTokens,
            uint256 bearTokens
        )
    {
        return (vaultHelper.getLiqAddTokens(vault, eth));
    }

    function getLiqRemoveTokens(address vault, uint256 eth)
        public
        view
        virtual
        returns (
            uint256 bullEquity,
            uint256 bearEquity,
            uint256 bullTokens,
            uint256 bearTokens,
            uint256 feesPaid
        )
    {
        return (vaultHelper.getLiqRemoveTokens(vault, eth));
    }

    function proposeVaultPriceAggregator(address account) public onlyOwner() {
        vaultHelperPropose = account;
    }

    function updateVaultAggregator() public {
        vaultHelper = VaultHelperInterface(vaultHelperPropose);
        vaultHelperPropose = address(0);
    }
}

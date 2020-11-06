// SPDX-License-Identifier: SSPL-1.0

/// @title Price Aggregator Proxy Contract

pragma solidity >=0.6.4 <0.8.0;

import "./Ownable.sol";
import "./Interfaces/PriceAggregatorInterface.sol";

contract PriceAggregatorProxy is Owned {
    PriceAggregatorInterface public priceAggregator;
    address public priceAggregatorPropose;

    // @param {int256[], uint256} priceRequest - returns lastUpdated
    function priceRequest(address vault, uint256 lastUpdated) public view virtual returns (int256[] memory, uint256) {
        (int256[] memory priceData, uint256 roundID) = priceAggregator.priceRequest(vault, lastUpdated);

        return (priceData, roundID);
    }

    // @param {roundIdCheck} bool
    function roundIdCheck(address vault) public view returns (bool) {
        return (priceAggregator.roundIdCheck(vault));
    }

    // @param {proposeVaultPriceAggregator} public onlyOwner
    function proposeVaultPriceAggregator(address account) public onlyOwner() {
        priceAggregatorPropose = account;
    }

    // @param {updateVaultAggregator} priceAggregatorPropose
    function updateVaultAggregator() public {
        priceAggregator = PriceAggregatorInterface(priceAggregatorPropose);
        priceAggregatorPropose = address(0);
    }
}

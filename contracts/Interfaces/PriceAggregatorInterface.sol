// SPDX-License-Identifier: SSPL-1.0

/// @title Price Aggregator Interface Contract

pragma solidity >=0.6.6 <0.8.0;

interface PriceAggregatorInterface {
    function registerVaultAggregator(address oracle) external;

    function priceRequest(address vault, uint256 lastUpdated) external view returns (int256[] memory, uint256);

    function roundIdCheck(address vault) external view returns (bool);
}

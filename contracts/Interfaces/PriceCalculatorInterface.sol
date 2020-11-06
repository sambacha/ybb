// SPDX-License-Identifier: SSPL-1.0

pragma solidity =>0.6.0 <0.8.0;

/// @title Price Calculator Interface

// TODO: JSDOC DOCUMENTATION

interface PriceCalculatorInterface {
    function getUpdatedPrice(address vault, uint256 latestRoundId)
        external
        view
        returns (
            uint256[6] memory latestPrice,
            uint256 rRoundId,
            bool updated
        );

    function getKFactor(
        uint256 targetEquity,
        uint256 bullEquity,
        uint256 bearEquity,
        uint256 totalEquity
    ) external view returns (uint256 kFactor);
}

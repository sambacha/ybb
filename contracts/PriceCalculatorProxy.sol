// SPDX-License-Identifier: SSPL-1.0

/// @title Price Calculator Proxy Interface

pragma solidity >=0.6.6 <0.8.0;

import "./Ownable.sol";
import "./Interfaces/PriceCalculatorInterface.sol";

contract PriceCalculatorProxy is Owned {
    PriceCalculatorInterface public PriceCalculator;
    address public PriceCalculatorPropose;

    function getUpdatedPrice(address vault, uint256 latestRoundId)
        public
        view
        virtual
        returns (
            uint256[6] memory latestPrice,
            uint256 rRoundId,
            bool updated
        )
    {
        return (PriceCalculator.getUpdatedPrice(vault, latestRoundId));
    }

    function proposePriceCalculator(address account) public onlyOwner() {
        PriceCalculatorPropose = account;
    }

    function updatePriceCalculator() public {
        PriceCalculator = PriceCalculatorInterface(PriceCalculatorPropose);
        PriceCalculatorPropose = address(0);
    }
}

// SPDX-License-Identifier: SSPL-1.0

/// @title Router Contract for Yearn BearBull 

pragma solidity >=0.6.6 <0.8.0;

import "./Interfaces/IERC20.sol";
import "./Interfaces/VaultInterface.sol";

contract Router {
    // FIXME Linter: Code contains empty blocks
    constructor() public {}

    // FIXME Linter: Avoid to make time-based decisions in business logic [not-rely-on-time]
    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, "EXPIRED");
        _;
    }

    // Linter: Code contains empty blocks
    receive() external payable {}

    /**
     * buyBullTokens
     * @param {uint256} buyBullTokens - Vault, Amount, minPrice, maxPrice, deadline
     * @return {buyBullTokens} reuturns buyBullTokens
     */

    function buyBullTokens(
        address payable vault,
        uint256 minPrice,
        uint256 maxPrice,
        uint256 deadline
    )
        public
        payable
        //FIXME Linter: Visibility modifier must be first in list of modifiers [visibility-modifier-order]
        ensure(deadline)
    {
        vaultInterface ivault = vaultInterface(vault);
        address token = ivault.getBullToken();
        ivault.updatePrice();
        uint256 price = ivault.getPrice(token);
        require(price >= minPrice && price <= maxPrice, "buyBull FFFF");
        vault.transfer(address(this).balance);
        ivault.tokenBuy(token, msg.sender);
    }

    /**
     * sellBullTokens
     * @param {uint256} sellBullTokens - Vault, Amount, minPrice, maxPrice, deadline
     * @return {sellBullTokens} reuturns sellBullTokens
     */

    function sellBullTokens(
        address vault,
        uint256 amount,
        uint256 minPrice,
        uint256 maxPrice,
        uint256 deadline
    ) public ensure(deadline) {
        vaultInterface ivault = vaultInterface(vault);
        address token = ivault.getBullToken();
        ivault.updatePrice();

        IERC20 itoken = IERC20(token);
        uint256 price = ivault.getPrice(token);
        require(price >= minPrice && price <= maxPrice, "sellBull FFFF");
        require(itoken.transferFrom(msg.sender, vault, amount));
        ivault.tokenSell(token, msg.sender);
    }

    /**
     * buyBearTokens
     * @param {uint256} buyBearTokens - Vault, Amount, minPrice, maxPrice, deadline
     * @return {buyBearTokens} reuturns buyBearTokens
     */
    function buyBearTokens(
        address payable vault,
        uint256 minPrice,
        uint256 maxPrice,
        uint256 deadline
    ) public payable ensure(deadline) {
        vaultInterface ivault = vaultInterface(vault);
        address token = ivault.getBearToken();
        ivault.updatePrice();
        uint256 price = ivault.getPrice(token);
        require(price >= minPrice && price <= maxPrice, "buyBear FFFF");
        vault.transfer(address(this).balance);
        ivault.tokenBuy(token, msg.sender);
    }

    /**
     * sellBearTokens
     * @param {uint256} sellBearTokens - Vault, Amount, minPrice, maxPrice, deadline
     * @return {sellBearTokens} returns sellBearTokens
     */

    function sellBearTokens(
        address vault,
        uint256 amount,
        uint256 minPrice,
        uint256 maxPrice,
        uint256 deadline
    ) public ensure(deadline) {
        vaultInterface ivault = vaultInterface(vault);
        address token = ivault.getBearToken();
        ivault.updatePrice();
        IERC20 itoken = IERC20(token);
        uint256 price = ivault.getPrice(token);
        require(price >= minPrice && price <= maxPrice, "PRICE FFFF");
        require(itoken.transferFrom(msg.sender, vault, amount));
        ivault.tokenSell(token, msg.sender);
    }
}

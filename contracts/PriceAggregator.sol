// SPDX-License-Identifier: SSPL-1.0

/// @title Price Aggregator Contract
// SEE 'TODO'

pragma solidity >=0.6.6 <0.8.0;

import "./Ownable.sol";
import "./lib/SafeMath.sol";
import "./Interfaces/AggregatorInterface.sol";
import "./Interfaces/VaultInterface.sol";

contract PriceAggregator is Owned {
    using SafeMath for uint256;

    constructor() public {}

    // Linter: Contract name must be in CamelCase [contract-name-camelcase]
    // WONTFIX

    /** LINTER-IGNORE */
    struct vaultStruct {
        AggregatorInterface ref;
    }

    // @note Vault address => vaultStruct

    mapping(address => vaultStruct) public refVault;

    uint256 public maxUpdates = 50;

    // @param {int256[], uint256} priceRequest
    function priceRequest(address vault, uint256 lastUpdated) public view returns (int256[] memory, uint256) {
        uint256 currentRound = refVault[vault].ref.latestRound();
        if (currentRound > lastUpdated) {
            uint256 pricearrayLength = currentRound.add(1).sub(lastUpdated);
            pricearrayLength = pricearrayLength > maxUpdates ? maxUpdates : pricearrayLength;
            int256[] memory pricearray = new int256[](pricearrayLength);
            pricearray[0] = refVault[vault].ref.getAnswer(lastUpdated);
            for (uint256 i = 1; i < pricearrayLength; i++) {
                pricearray[pricearrayLength.sub(i)] = refVault[vault].ref.getAnswer(currentRound.add(1).sub(i));
            }
            return (pricearray, currentRound);
        } else {
            return (new int256[](0), currentRound);
        }
    }

    /**
     * Price Check from Vault
     * @param {address} roundIdCheck - Returns false if the price is not updated on vault.
     * @return {latestRound} true or false
     */

    function roundIdCheck(address vault) public view returns (bool) {
        if (vaultInterface(vault).getLatestRoundId() < refVault[vault].ref.latestRound()) {
            return (false);
        } else return (true);
    }

    // TODO PROVIDE ERROR MESSAGE
    function setMaxUpdates(uint256 amount) public onlyOwner() {
        require(amount > 1);
        maxUpdates = amount;
    }

    /**
     * Chainlink Connection
     * @param {address} registerVaultAggregator - Functions setting and updating vault to chainlink aggregator contract connections
     * @return {AggregatorInterface} Can only be called by vault proxy, initiates pair
     */

    function registerVaultAggregator(address aggregator) public {
        refVault[msg.sender].ref = AggregatorInterface(aggregator);
    }
}

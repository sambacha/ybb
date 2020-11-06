pragma solidity =>0.6.0 <0.8.0;


/// @title Vault Helper Interface Contract

// TODO: JSDOC DOCUMENTATION
interface VaultHelperInterface {
    function getBonus(
        address vault,
        address token,
        uint256 eth
    ) external view returns (uint256 bonus);

    function getPenalty(
        address vault,
        address token,
        uint256 eth
    ) external view returns (uint256 penalty);

    function getSharePrice(address vault) external view returns (uint256 sharePrice);

    function getLiqAddTokens(address vault, uint256 eth)
        external
        view
        returns (
            uint256 bullEquity,
            uint256 bearEquity,
            uint256 bullTokens,
            uint256 bearTokens
        );

    function getLiqRemoveTokens(address vault, uint256 eth)
        external
        view
        returns (
            uint256 bullEquity,
            uint256 bearEquity,
            uint256 bullTokens,
            uint256 bearTokens,
            uint256 feesPaid
        );
}

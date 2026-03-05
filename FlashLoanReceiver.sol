// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IPool {
    function flashLoanSimple(
        address receiverAddress,
        address asset,
        uint256 amount,
        bytes calldata params,
        uint16 referralCode
    ) external;
}

/**
 * @title FlashLoanReceiver
 * @dev Professional implementation for executing Aave V3 Flash Loans.
 */
contract FlashLoanReceiver {
    address public immutable poolAddress;

    constructor(address _poolAddress) {
        poolAddress = _poolAddress;
    }

    /**
     * @dev Initiate a flash loan.
     */
    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        IPool(poolAddress).flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    /**
     * @dev This function is called by the Aave pool after receiving the tokens.
     */
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool) {
        // 1. Logic for Arbitrage / Liquidation / Refinancing goes here
        // Example: Trade on Dex A, Sell on Dex B
        
        // 2. Approve the Pool to pull the debt + premium
        uint256 amountToReturn = amount + premium;
        IERC20(asset).approve(poolAddress, amountToReturn);

        return true;
    }

    receive() external payable {}
}

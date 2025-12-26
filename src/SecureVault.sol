// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SecureVault {
    mapping(address => uint256) private balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Everyone can deposit ETH into their own vault
    function deposit() external payable {
        require(msg.value > 0, "no ether");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Users can withdraw their full balance (pull pattern)
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "nothing to withdraw");

        // Effects
        balances[msg.sender] = 0;

        // Interaction
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok);

        emit Withdrawn(msg.sender, amount);
    }

    // View function to check a user's balance
    function balanceOf(address user) external view returns (uint256) {
        return balances[user];
    }
}

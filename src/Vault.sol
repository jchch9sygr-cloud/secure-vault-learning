// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Vault {
    //Mapping that stores each user's deposited ETH balance in wei. Marked as private to restrict direct access
    mapping(address => uint256) private balances;

    function balanceOf(address user) external view returns (uint256) {
        return balances[user];
        }

    function deposit() external payable {
        require(msg.value > 0, "zero deposit");
        balances[msg.sender] += msg.value;
        }

    function withdraw(uint256 amount) external {
        require(amount > 0, "zero amount");
        require(balances[msg.sender] >= amount, "insufficient");

        balances[msg.sender] -= amount;

        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "eth transfer failed");
    }

}

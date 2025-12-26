// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SecureVault.sol";

contract SecureVaultTest is Test {
    SecureVault vault;

    address alice = address(0xA11CE);
    address bob   = address(0xB0B);

    function setUp() public {
        vault = new SecureVault();
    }

    //Test if deposit increases balance
    function testDepositIncreaseBalance() public {
        //We are giving alice 1 ether to her address
        vm.deal(alice, 1 ether);
        //msg.sender = alice
        vm.prank(alice);
        //calls the function deposit() in vault
        vault.deposit{value: 1 ether}();
        //calls the function view //balanceOf(alice)
        uint256 balance = vault.balanceOf(alice);
        //checks if balance of alice is now 1 ether, if yes test good
        assertEq(balance, 1 ether);
    }

    //Test if withdraw empties Balance
    function testWithdrawEmptiesBalance() public {
        //gives alice 1 ether
        vm.deal(alice, 1 ether);
        //msg.sender = alice
        vm.prank(alice);
        //deposit in alice vault 1 ether
        vault.deposit{value: 1 ether}();
        //shows alice balance before the withdraw
        uint256 aliceBalanceBefore = alice.balance;
        //msg.sender = alice
        vm.prank(alice);
        //withdraw the balance from the vault
        vault.withdraw();
        //shows alice balance after the withdrawn
        uint256 balanceAfter = vault.balanceOf(alice);
        //checks if alice balance is now 0
        assertEq(balanceAfter, 0);
        //store alice balance after withdrawing
        uint256 aliceBalanceAfter = alice.balance;
        //verify alice has more ETH after withdrawal than before
        assertGt(aliceBalanceAfter, aliceBalanceBefore);
    }

    //Test if withdraw without balance reverts
    function testWithdrawWithoutBalanceReverts() public {
        //msg.sender = alice
        vm.prank(alice);
        //check if the next call reverts
        vm.expectRevert("nothing to withdraw");
        //withdraw the balance from the vault
        vault.withdraw();
    }

    //Test if only User can Withdraw its own Funds
    function testOnlyUserCanWithdrawOwnFunds() public {
        //gives alice 1 ether
        vm.deal(alice, 1 ether);
        //msg.sender = alice
        vm.prank(alice);
        //calls the function deposit in vault
        vault.deposit{value: 1 ether}();

        //msg sender = bob
        vm.prank(bob);
        //checks if next call reverts
        vm.expectRevert("nothing to withdraw");
        //withdraw the balance from vault
        vault.withdraw();

        //store alice Balance 
        uint256 aliceBalance = vault.balanceOf(alice);
        //checks if balance is 1 eth
        assertEq(aliceBalance, 1 ether);
    }
}
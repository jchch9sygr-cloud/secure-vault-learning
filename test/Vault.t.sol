// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vault.sol";
<<<<<<< HEAD
import "../src/ReentrancyAttacker.sol";
=======
import "../src/Attacker.sol";
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc

contract VaultTest is Test {
    Vault vault;

    address alice = address(0xA11CE);
    address bob = address(0xB0B);

    function setUp() public {
        vault = new Vault();

        vm.deal(alice, 10 ether);
        vm.deal(bob, 10 ether);
    }

<<<<<<< HEAD
=======
    // tests if deposit increases the balance
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc
    function testDepositIncreasesBalance() public {
        vm.prank(alice);
        vault.deposit{value: 1 ether}();

        assertEq(vault.balanceOf(alice), 1 ether);
    }

<<<<<<< HEAD
=======
    // tests if deposit does not affect other users
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc
    function testDepositDoesNotAffectOtherUsers() public {
        vm.prank(alice);
        vault.deposit{value: 1 ether}();

        assertEq(vault.balanceOf(alice), 1 ether);
        assertEq(vault.balanceOf(bob), 0);
    }

<<<<<<< HEAD
=======
    // tests if withdraw reduces balance and sends eth
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc
    function testWithdrawReducesBalanceAndSendsETH() public {
        vm.startPrank(alice);

        vault.deposit{value: 2 ether}();
        uint256 ethBefore = alice.balance;

        vault.withdraw(1 ether);

        vm.stopPrank();

        assertEq(vault.balanceOf(alice), 1 ether);
        assertEq(alice.balance, ethBefore + 1 ether);
    }

<<<<<<< HEAD
=======
    // tests if withdraw more than balance reverts
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc
    function testWithdrawMoreThanBalanceReverts() public {
        vm.prank(alice);
        vault.deposit{value: 1 ether}();

        vm.prank(alice);
        vm.expectRevert("insufficient");
        vault.withdraw(2 ether);
    }
<<<<<<< HEAD
    function testReentrancyAttackFails() public {
        ReentrancyAttacker attacker = new ReentrancyAttacker(address(vault));
=======

    // tests that reentrancy attack fails
    function testReentrancyAttackFails() public {
        Attacker attacker = new Attacker(address(vault));
>>>>>>> 6d004cd0bc5373ecd886ced2a3a8a028f7b55bdc

        vm.deal(address(attacker), 1 ether);

        vm.expectRevert();
        attacker.attack{value: 1 ether}();

        assertEq(vault.balanceOf(address(attacker)), 0);
    }
}

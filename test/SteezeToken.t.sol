// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import "./utilities/WhenTransferringTokens.sol";
import "ds-test/test.sol";

contract WhenAliceHasSufficientFunds is WhenTransferringTokens {
    uint256 internal mintAmount = maxTransferAmount;

    function setUp() public override {
        WhenTransferringTokens.setUp();
        console.log("When Alice has sufficient funds");
        _mint(alice, mintAmount);
    }

    function itTransfersAmountCorrectly(
        address from,
        address to,
        uint256 amount
    ) public {
        uint256 fromBalance = balanceOf(from);
        bool success = transferToken(from, to, amount);

        assertTrue(success);
        assertEqDecimal(
            balanceOf(from),
            fromBalance - amount, decimals()
        );
        assertEqDecimal(
            balanceOf(to),
            amount, decimals()
        );
    }

    function testTransferAllTokens() public {
        uint256 t = maxTransferAmount;
        itTransfersAmountCorrectly(alice, bob, t);
    }

    function testTransferHalfTokens() public {
        uint256 t = maxTransferAmount / 2;
        itTransfersAmountCorrectly(alice, bob, t);
    }

    function testTransferOneToken() public {
        itTransfersAmountCorrectly(alice, bob, 1);
    }
}

contract WhenAliceHasInsufficientFunds is WhenTransferringTokens {
    uint256 internal mintAmount = maxTransferAmount - 1e18;

    function setUp() public override {
        WhenTransferringTokens.setUp();
        console.log("When Alice has insufficient funds");
        _mint(alice, mintAmount);
    }

    function itRevertsTransfer(
        address from,
        address to,
        uint256 amount,
        string memory expRevertMessage
    ) public {
        vm.expectRevert(abi.encodePacked(expRevertMessage));
        transferToken(from, to, amount);
    }


    function testCannotTransferMoreThanAvailable() public {
        itRevertsTransfer({
            from: alice,
            to: bob,
            amount: maxTransferAmount,
            expRevertMessage: "ERC20: transfer amount exceeds balance"
        });
    }

    function testCannotTransferToZero() public {
        itRevertsTransfer({
            from: alice,
            to: address(0),
            amount: mintAmount,
            expRevertMessage: "ERC20: transfer to the zero address"
        });
    }
}

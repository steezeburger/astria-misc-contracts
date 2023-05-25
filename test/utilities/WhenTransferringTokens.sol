pragma solidity >=0.8;

import {console} from "forge-std/console.sol";
import {BaseSetup} from "./BaseSetup.sol";

contract WhenTransferringTokens is BaseSetup {
    uint256 internal maxTransferAmount = 12e18;

    function setUp() public virtual override {
        BaseSetup.setUp();
        console.log("When transferring tokens");
    }

    function transferToken(
        address from,
        address to,
        uint256 transferAmount
    ) public returns (bool) {
        vm.prank(from);
        return this.transfer(to, transferAmount);
    }
}

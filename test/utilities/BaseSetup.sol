// SPDX-License-Identifier: MIT
pragma solidity >=0.8;

import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import "./Utilities.sol";
import "../../src/SteezeToken.sol";

contract BaseSetup is SteezeToken, Test {
    Utilities internal utils;
    address payable[] internal users;

    address internal alice;
    address internal bob;

    function setUp() public virtual {
        utils = new Utilities();
        users = utils.createUsers(2);
        alice = users[0];
        vm.label(alice, "Alice");
        bob = users[1];
        vm.label(bob, "Bob");
    }
}

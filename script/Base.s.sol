// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import { Script } from "forge-std/Script.sol";

abstract contract BaseScript is Script {
    /// @dev Included to enable compilation of the script without a $MNEMONIC environment variable.
    string internal constant TEST_MNEMONIC = "test test test test test test test test test test test junk";

    /// @dev Needed for the deterministic deployments.
    bytes32 internal constant ZERO_SALT = bytes32(0);

    /// @dev The address of the contract deployer.
    address internal deployer;

    /// @dev Used to derive the deployer's address.
    string internal mnemonic;

    constructor() {
        mnemonic = vm.envOr("MNEMONIC", TEST_MNEMONIC);
        (deployer,) = deriveRememberKey({ mnemonic: mnemonic, index: 0 });
    }

    modifier broadcaster() {
        vm.startBroadcast(deployer);
        _;
        vm.stopBroadcast();
    }
}

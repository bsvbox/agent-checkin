// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {AgentCheckin} from "../src/AgentCheckin.sol";

/// @notice Deploy AgentCheckin to BNB Chain (chain 56).
///         Registry is the official SPACE ID Agent ID registry.
///         Usage:
///           forge script script/Deploy.s.sol --rpc-url https://bsc-dataseed1.binance.org \
///             --broadcast --verify --etherscan-api-key $BSCSCAN_API_KEY
///         The deployer private key comes from --private-key or the keystore.
///         NEVER put a real private key in this repo.
contract Deploy is Script {
    address public constant REGISTRY = 0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F;

    function run() external returns (AgentCheckin deployed) {
        vm.startBroadcast();
        deployed = new AgentCheckin(REGISTRY);
        vm.stopBroadcast();
    }
}

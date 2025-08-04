// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {CounterV2} from "../src/CounterV2.sol";

contract Upgrade is Script {
    function run(address proxyAddress) public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        bytes memory data;
        CounterV2 newImplementation = new CounterV2();
        UUPSUpgradeable(proxyAddress).upgradeToAndCall(address(newImplementation), data);

        vm.stopBroadcast();
    }
}

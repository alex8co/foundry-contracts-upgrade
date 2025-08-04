// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Deploy} from "../script/Deploy.s.sol";
import {Upgrade} from "../script/Upgrade.s.sol";
import {CounterV1} from "../src/CounterV1.sol";
import {CounterV2} from "../src/CounterV2.sol";

contract UpgradeTest is Test {
    Deploy public deployer;
    Upgrade public upgrader;
    CounterV1 public proxy;

    function setUp() public {
        deployer = new Deploy();
        upgrader = new Upgrade();
        address proxyAddress = deployer.run();
        proxy = CounterV1(proxyAddress);
    }

    function test_Upgrade() public {
        // Interact with V1
        proxy.increment();
        assertEq(proxy.number(), 1, "V1 increment failed");

        // Upgrade to V2
        upgrader.run(address(proxy));

        // Interact with V2
        CounterV2 proxyV2 = CounterV2(address(proxy));
        proxyV2.decrement();
        assertEq(proxyV2.number(), 0, "V2 decrement failed");
    }

    function test_RevertOnDecrementFromZero() public {
        // Upgrade to V2
        upgrader.run(address(proxy));

        // Interact with V2
        CounterV2 proxyV2 = CounterV2(address(proxy));

        // number is 0 initially
        assertEq(proxyV2.number(), 0, "Initial number should be 0");

        // Expect decrement to revert with our custom error
        vm.expectRevert("Counter: Cannot decrement below zero");
        proxyV2.decrement();
    }
}

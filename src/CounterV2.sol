// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CounterV1} from "./CounterV1.sol";

contract CounterV2 is CounterV1 {
    function decrement() public {
        require(number > 0, "Counter: Cannot decrement below zero");
        number--;
    }
}

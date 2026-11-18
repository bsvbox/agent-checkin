// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {AgentCheckin} from "../src/AgentCheckin.sol";

/// @notice Minimal stand-in for the SPACE ID Agent ID registry (ERC-721 balanceOf only).
contract MockRegistry {
    mapping(address => uint256) public balances;

    function setBalance(address who, uint256 amount) external {
        balances[who] = amount;
    }

    function balanceOf(address owner) external view returns (uint256) {
        return balances[owner];
    }
}

contract AgentCheckinTest is Test {
    AgentCheckin public checkin;
    MockRegistry public registry;

    address public holder = address(0xA11CE);
    address public stranger = address(0xBEEF);

    event Checkin(address indexed agent, uint256 indexed day, uint256 streak);

    function setUp() public {
        vm.warp(1_700_000_000); // realistic mainnet-like timestamp
        registry = new MockRegistry();
        checkin = new AgentCheckin(address(registry));
        registry.setBalance(holder, 1);
    }

    function test_nonHolderReverts() public {
        vm.prank(stranger);
        vm.expectRevert(AgentCheckin.NoAgentId.selector);
        checkin.checkIn();
    }

    function test_firstCheckin() public {
        vm.prank(holder);
        vm.expectEmit(true, true, false, true, address(checkin));
        emit Checkin(holder, block.timestamp / 1 days + 1, 1);
        checkin.checkIn();

        assertEq(checkin.streakOf(holder), 1);
        assertEq(checkin.totalCheckins(), 1);
        assertEq(checkin.uniqueAgents(), 1);
        assertTrue(checkin.hasCheckedInToday(holder));
    }

    function test_doubleCheckinSameDayReverts() public {
        vm.prank(holder);
        checkin.checkIn();

        vm.prank(holder);
        vm.expectRevert(AgentCheckin.AlreadyCheckedInToday.selector);
        checkin.checkIn();
    }

    function test_streakIncrementsNextDay() public {
        vm.prank(holder);
        checkin.checkIn();

        vm.warp(block.timestamp + 1 days);
        vm.prank(holder);
        checkin.checkIn();

        assertEq(checkin.streakOf(holder), 2);
        assertEq(checkin.totalCheckins(), 2);
        assertEq(checkin.uniqueAgents(), 1);
    }

    function test_streakResetsAfterGap() public {
        vm.prank(holder);
        checkin.checkIn();

        vm.warp(block.timestamp + 1 days);
        vm.prank(holder);
        checkin.checkIn();
        assertEq(checkin.streakOf(holder), 2);

        vm.warp(block.timestamp + 3 days);
        vm.prank(holder);
        checkin.checkIn();

        assertEq(checkin.streakOf(holder), 1);
        assertEq(checkin.totalCheckins(), 3);
        assertEq(checkin.uniqueAgents(), 1);
    }

    function test_uniqueAgentsCountsOnce() public {
        address second = address(0xC0FFEE);
        registry.setBalance(second, 2);

        vm.prank(holder);
        checkin.checkIn();
        vm.prank(second);
        checkin.checkIn();

        vm.warp(block.timestamp + 1 days);
        vm.prank(holder);
        checkin.checkIn();
        vm.prank(second);
        checkin.checkIn();

        assertEq(checkin.uniqueAgents(), 2);
        assertEq(checkin.totalCheckins(), 4);
    }

    function test_hasCheckedInTodayFalseBeforeCheckin() public {
        assertFalse(checkin.hasCheckedInToday(holder));
    }
}

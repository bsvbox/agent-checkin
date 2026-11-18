// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title AgentCheckin
/// @notice Daily check-in dApp for Agent ID holders.
///         Entry for the Agent ID Hackathon (Binance Wallet x BNB Chain).
/// @dev Gate: the official SPACE ID Agent ID registry on BNB Chain (ERC-721).
///      An address may check in only if it holds at least one Agent ID.
///      One check-in per UTC day. Streak grows on consecutive days, resets on a gap.
///      No funds are held, no owner, no upgrade path, no token or NFT is minted.
///      The registry address is immutable, set once at deploy. On BNB mainnet it is
///      0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F (the same gate AGCC used).
///      The contract is a single file with no imports, so BscScan verification is trivial.
interface IAgentIdRegistry {
    function balanceOf(address owner) external view returns (uint256);
}

contract AgentCheckin {
    IAgentIdRegistry public immutable agentIdRegistry;

    uint256 public totalCheckins;
    uint256 public uniqueAgents;

    mapping(address => uint256) public lastCheckinDay;
    mapping(address => uint256) public streakOf;
    mapping(address => bool) public hasCheckedIn;

    event Checkin(address indexed agent, uint256 indexed day, uint256 streak);

    error NoAgentId();
    error AlreadyCheckedInToday();

    constructor(address registry_) {
        agentIdRegistry = IAgentIdRegistry(registry_);
    }

    /// @notice Check in for today (UTC day). Only Agent ID holders.
    function checkIn() external {
        if (agentIdRegistry.balanceOf(msg.sender) == 0) revert NoAgentId();

        // Day numbers start at 1, so the zero value of the mapping always means
        // "never checked in" and can never collide with a real day.
        uint256 day = block.timestamp / 1 days + 1;
        if (lastCheckinDay[msg.sender] == day) revert AlreadyCheckedInToday();

        uint256 streak = lastCheckinDay[msg.sender] == day - 1
            ? streakOf[msg.sender] + 1
            : 1;

        lastCheckinDay[msg.sender] = day;
        streakOf[msg.sender] = streak;
        totalCheckins += 1;

        if (!hasCheckedIn[msg.sender]) {
            hasCheckedIn[msg.sender] = true;
            uniqueAgents += 1;
        }

        emit Checkin(msg.sender, day, streak);
    }

    /// @notice True if `agent` already checked in today (UTC day).
    function hasCheckedInToday(address agent) external view returns (bool) {
        return lastCheckinDay[agent] == block.timestamp / 1 days + 1;
    }
}

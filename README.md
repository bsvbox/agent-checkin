# Agent Check-in — Agent ID Hackathon entry

Daily check-in dApp for Agent ID holders. Built for the Agent ID Hackathon
(Binance Wallet x BNB Chain, submission 18 Nov – 9 Dec 2026 15:00 WIB).

## Concept

One function: `checkIn()` once per UTC day, only for wallets that hold an
Agent ID. Each check-in records the streak and shows up on a leaderboard.
Agent ID is the core gate, not a decoration, which is what both award
categories reward:

- **Pioneer Award** (on-chain ranking): every check-in is 1 transaction from
  1 Agent ID address, feeding the "interacting addresses" and "transaction
  count" metrics directly.
- **Innovation Award** (jury): Agent ID depth is the whole product; needs a
  live product + at least 30 Agent ID addresses interacting during the
  submission period.

## Contract

`src/AgentCheckin.sol` — single file, no imports, no owner, no upgrade path,
no funds held, no token or NFT minted.

- Gate: `balanceOf` on the official SPACE ID Agent ID registry
  `0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F` (same gate AGCC used, proven
  on mainnet). The registry address is immutable, set once at deploy.
- `checkIn()`: reverts `NoAgentId` without an Agent ID, reverts
  `AlreadyCheckedInToday` on a second check-in the same UTC day. Streak +1 on
  consecutive days, reset to 1 after a gap.
- Views: `streakOf`, `lastCheckinDay`, `hasCheckedInToday`, `totalCheckins`,
  `uniqueAgents`. Event: `Checkin(agent, day, streak)`.
- Day numbers start at 1 (`block.timestamp / 1 days + 1`), so the zero value
  of the mapping always means "never checked in". Found during testing: with
  day 0 the first check-in reverted as "already checked in", fixed before
  deploy.

## Tests

`forge test` — 7 tests, all passing (18 Nov 2026):

- non-holder reverts, first check-in (streak 1, totals 1/1, event),
  double check-in same day reverts, streak increments next day,
  streak resets after a gap, unique agents counted once,
  `hasCheckedInToday` false before check-in.

## Gas (measured, `forge test --gas-report`; live BSC gas 0,05 gwei, 18 Nov 21:01 WIB)

- Deploy: **567.353 gas** ≈ **0,000028 BNB** (±$0,02). Even at 0,5 gwei it is
  ±0,00028 BNB.
- `checkIn`: first check-in ±141.600 gas (cold storage), typical ±48.000,
  repeat-day ±27.300. At 0,05 gwei a typical check-in is ±0,0000024 BNB,
  a fraction of a cent for each user.

## Deploy (not done yet — deployer wallet still to be chosen)

```bash
forge script script/Deploy.s.sol \
  --rpc-url https://bsc-dataseed1.binance.org \
  --broadcast --verify --etherscan-api-key $BSCSCAN_API_KEY
```

Then verify on BscScan, build the one-page frontend, and submit via the
official form before 9 Dec 2026 15:00 WIB.

## Submission checklist

- [x] Deployer wallet chosen: BAW (mase 18 Nov 21:09 WIB)
- [x] Deployed to BSC mainnet 18 Nov 21:12 WIB via the deterministic deployment
      proxy (BAW cannot send raw creation txs): tx
      0x49d14f79a27c5a0dd662da3717aba0067b061a6bdd5ef648cc9dd79fadf53403,
      block 134325311, gas 568.955 (±0,0000386 BNB), contract
      0x47fedd8b285dd951b835bb18eced4adb22a44c7d (predicted address matched),
      agentIdRegistry() verified on-chain = 0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F.
      BAW after deploy: 0,00099527 BNB (was 0,00103384 before — up from
      0,00013195 on 14 Nov; cause of the rise not verified).
- [x] Verify on BscScan: BERHASIL 18 Nov 21:18 WIB — "Exact Match". Percobaan 1
      gagal karena Optimization: Yes; percobaan 2 dengan Optimization: No
      langsung cocok. Compiler v0.8.24+commit.e11b9ed9, Optimization Enabled: 0,
      Runs: 200, Contract Name AgentCheckin, constructor registry_
      0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F, tx pembuatan
      0x49d14f79a27c5a0dd662da3717aba0067b061a6bdd5ef648cc9dd79fadf53403.
- [x] Frontend CONFIG filled with the mainnet address
- [x] Host the frontend page — halaman statis "Agent Check-in" selesai
      dibangun + diaudit 18 Nov 21:26 WIB, lalu diperbaiki 21:46 WIB: (1) RPC
      baca kini publicnode utama + dataseed1/3 cadangan, semua pembacaan
      retry lintas RPC; (2) seluruh teks antarmuka jadi Bahasa Inggris
      (keputusan mase 21:44 WIB). Diverifikasi builder: totalCheckins()=1
      terbaca di ketiga RPC; wallet Rabby 0x6a74...5941 balanceOf=0 jadi
      halaman akan menampilkan "This wallet has no Agent ID" + tombol
      nonaktif; eth_getLogs dataseed memang selalu ditolak (limit exceeded).
      CATATAN: link publik masih menampilkan versi lama — versi baru ini
      baru terbit ke link publik bila mase minta share ulang.
- [x] Frontend CONFIG filled with the mainnet address
- [ ] Host the frontend page (website URL needed for submission)
- [ ] Submit project (name, website, contract address, Agent ID usage)
- [ ] Drive 30+ Agent ID holders to check in (X, community)
- [ ] Post-mortem

## Post-mortem

To be written after submission.

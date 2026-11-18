# Submission draft — Agent ID Hackathon

Fill the contract address + website after deploy. Do NOT submit before mase
approves the final texts.

## Project name

Agent Check-in

## One-line pitch

Daily check-in for Agent ID holders on BNB Chain: check in once a day,
build your streak, climb the leaderboard.

## Description (for the form)

Agent Check-in is a minimal dApp that turns an Agent ID into daily on-chain
activity. A holder connects their Binance Wallet, checks in once per UTC day,
and the contract records their streak. A public leaderboard ranks agents by
streak. No funds are held, no token is minted, and the contract is a single
open-source file verified on BscScan.

## How Agent ID is used (for the form)

Agent ID is the core gate, not an add-on. The contract calls `balanceOf` on
the official SPACE ID Agent ID registry
(0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F) inside `checkIn()`: wallets
without an Agent ID revert with `NoAgentId`. Every check-in is therefore a
real on-chain interaction from an Agent ID address, and the Pioneer metrics
(interacting Agent ID addresses, transaction count) are produced by the
product itself. Streaks and the leaderboard are derived from the `Checkin`
event, so any Agent ID holder can verify the ranking on-chain.

## Links

- Website: https://muse.ai/s/agent-check-in-kq6xyxuaxx50xrw/rPKJd8PS13hKEpNj6FxoaJDo2njvv6wFS-bS-xX0vKk (link publik, diterbitkan 18 Nov 21:32 WIB atas kata mase)
- Contract: **0x47fedd8b285dd951b835bb18eced4adb22a44c7d** (BSC mainnet, deployed
  18 Nov 2026 21:12 WIB, tx
  0x49d14f79a27c5a0dd662da3717aba0067b061a6bdd5ef648cc9dd79fadf53403, block
  134325311)
- BscScan: https://bscscan.com/address/0x47fedd8b285dd951b835bb18eced4adb22a44c7d
  (verified, "Exact Match", 18 Nov 21:18 WIB)
- **STATUS: SUBMITTED 18 Nov 2026 22:32 WIB** — konfirmasi halaman:
  "Survey already completed — You have already completed this survey.
  Thanks for your support to Binance." (form Chrome mase; Code Repository
  diperbaiki ke https://github.com/bsvbox/agent-checkin via Edit Response)
- Team Name: Agent Check-in (solo); Contact Email: iboxyz7@gmail.com;
  Telegram: @bsvbox; Reward Receiving Address:
  0x362EfA2466A6c6604ee2Dca9D08d4CfabB18b26F. Form TIDAK punya kolom untuk
  Agent ID mase.ai maupun Binance UID 54821112 (Q1-Q19 dicek, tidak ada).
- Demo video (Q12, wajib): https://github.com/bsvbox/agent-checkin/releases/download/v1.0/agent-checkin-demo.mp4 — 42 detik, 1280x720, MP4, dibuat 18 Nov 22:2x WIB dari screenshot asli halaman + narasi Inggris (TTS); dirilis sebagai release v1.0 (link permanen; link penyimpanan Muse kedaluwarsa 20 Nov jadi TIDAK dipakai).
- Announcement: https://www.binance.com/en/support/announcement/detail/95f5dbe0ea674a48a739b59e046648bf
- Submit form: https://app.binance.com/uni-qr/user-survey/fb26d2bd25e04329b1ba77c7b3811d23

## Pre-submit checks

- [x] Contract deployed to BSC mainnet
- [x] Contract verified on BscScan (single file, no imports, Exact Match)
- [x] Frontend CONFIG has the mainnet address, page built + audited
- [x] Website URL publik untuk form: https://muse.ai/s/agent-check-in-kq6xyxuaxx50xrw/rPKJd8PS13hKEpNj6FxoaJDo2njvv6wFS-bS-xX0vKk (diterbitkan 18 Nov 21:32 WIB atas kata mase)
- [x] Mase tested one real check-in from his own wallet (mase.ai) — via BAW
      18 Nov 21:41 WIB (phone browser could not connect Binance Wallet):
      tx 0x2ab6cd07a66541afd340aeac329224016897920fc8aeb40dee69d58382d7be0b,
      block 134329061, gas 141.440, streak 1, total 1, unique 1. BAW BNB
      0,00099527 → 0,00098640.
- [x] Texts above approved by mase (21:50 WIB, "Setuju")
- [x] Link publik diperbarui ke versi terbaru (Inggris + RPC fix) 21:50 WIB,
      URL sama: https://muse.ai/s/agent-check-in-kq6xyxuaxx50xrw/rPKJd8PS13hKEpNj6FxoaJDo2njvv6wFS-bS-xX0vKk

# deploy V1
## Start testnet
```bash
anvil --fork-url https://reth-ethereum.ithaca.xyz/rpc
```

## Set your environment variables first
```bash
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export INITIAL_VALUE=100
export OWNER_ADDRESS=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
export RPC_URL=http://127.0.0.1:8545
cast balance $OWNER_ADDRESS --ether --rpc-url $RPC_URL
```
### need verify by etherscan for deploy to sepolia
```bash
export SEPOLIA_RPC_URL=
export ETHERSCAN_API_KEY=
```

## Run the deploy script
```bash
forge script script/Deploy.s.sol:Deploy --sig "run()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY  --broadcast  --verify --etherscan-api-key $ETHERSCAN_API_KEY
cast balance $OWNER_ADDRESS --ether --rpc-url $RPC_URL
```

```
##### sepolia
== Return ==
0: address 0x63658b61F3134F2f39b236495aeFE21D48f886De
✅  [Success] Hash: 0x2adfb65b045f188a4f4efaa605e4869f5441fa7ec896e41a07b60e09cb277b44
Contract Address: 0x63658b61F3134F2f39b236495aeFE21D48f886De
##### sepolia
✅  [Success] Hash: 0x1b6c0761a1ebdaaad0aea556ea2abfd8b3898edd4de8049a760078a010876004
Contract Address: 0xCd791b15132F20232061FEAA26E792BD64B030Ca
```

```bash
forge verify-contract --chain sepolia  0xCd791b15132F20232061FEAA26E792BD64B030Ca  src/CounterV1.sol:CounterV1 --etherscan-api-key $ETHERSCAN_API_KEY
```
```
	Response: `OK`
	GUID: `cm4q6efccsagn4khhftl6wqfm5ce7gmukjd9ghgdzprssy2112`
	URL: https://sepolia.etherscan.io/address/0xcd791b15132f20232061feaa26e792bd64b030ca
```


```bash
export PROXY_ADDRESS=0x63658b61F3134F2f39b236495aeFE21D48f886De
```

```bash
cast call $PROXY_ADDRESS "number()" --rpc-url $RPC_URL
cast send $PROXY_ADDRESS "increment()"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY
cast call $PROXY_ADDRESS "number()" --rpc-url $RPC_URL
```

```bash
cast call $PROXY_ADDRESS "owner()(address)" --rpc-url $RPC_URL
```


# upgrade to V2
## Set your environment variables

## Run the upgrade script
```bash
forge script script/Upgrade.s.sol --sig "run(address)" $PROXY_ADDRESS  --rpc-url $RPC_URL --private-key $PRIVATE_KEY  --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

```
##### sepolia
✅  [Success] Hash: 0xe9cd59305f6533556f801ec780ac6e1bd3b66a28a769ebdc71bcaefe34cd1fcd
Contract Address: 0x3F8032CE3d01bD58E176ea6338807177F694E4d5
```

```bash
forge verify-contract --chain sepolia 0x3F8032CE3d01bD58E176ea6338807177F694E4d5 src/CounterV2.sol:CounterV2 --etherscan-api-key $ETHERSCAN_API_KEY
```

```
	Response: `OK`
	GUID: `dxaqzunrenbrceypwq8xubq3r9njwqn9kbb6cf6ilvviclgqhm`
	URL: https://sepolia.etherscan.io/address/0x3f8032ce3d01bd58e176ea6338807177f694e4d5
```


```bash
cast call $PROXY_ADDRESS "number()" --rpc-url $RPC_URL
cast send $PROXY_ADDRESS "increment()"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY
cast send $PROXY_ADDRESS "decrement()"  --rpc-url $RPC_URL --private-key $PRIVATE_KEY
cast call $PROXY_ADDRESS "number()" --rpc-url $RPC_URL
```

# other

```bash
cast balance $OWNER_ADDRESS --ether --rpc-url $RPC_URL
cast call $PROXY_ADDRESS "owner()(address)" --rpc-url $RPC_URL
cast wallet address $PRIVATE_KEY
cast balance $PROXY_ADDRESS --ether --rpc-url $RPC_URL
```

```
https://sepolia.etherscan.io/address/0x63658b61F3134F2f39b236495aeFE21D48f886De
```



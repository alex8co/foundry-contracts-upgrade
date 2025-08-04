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


## Run the deploy script
```bash
forge script script/Deploy.s.sol:Deploy --sig "run()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY  --broadcast
cast balance $OWNER_ADDRESS --ether --rpc-url $RPC_URL
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
forge script script/Upgrade.s.sol --sig "run(address)" $PROXY_ADDRESS  --rpc-url $RPC_URL --private-key $PRIVATE_KEY  --broadcast
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

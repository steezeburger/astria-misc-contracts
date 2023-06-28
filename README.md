# Status: Archived
This repository has been archived and is no longer maintained.

![status: inactive](https://img.shields.io/badge/status-inactive-red.svg)

## Anything of interest here has been implemented in a (slightly) cleaner monorepo that can be found at https://github.com/astriaorg/astria-web3. This repo also contains other fun things like a faucet and a web3 frontend.

---

## dependencies

* [foundry and forge](https://github.com/foundry-rs/foundry)

## setup

* run [dev-cluster](https://github.com/astriaorg/dev-cluster)

## deploy contracts

* Weth9 contract
  * NOTE - Currently the geth local account is hard coded into the dev-cluster configuration. This will be fixed soon. Until then, you may have to get the private key from someone else, or run dev-cluster with your own public key as the `executor_local_account`.

```bash
# deploy Weth9 contract first
export PRIV_KEY=123...
RUST_LOG=debug forge create --private-key $PRIV_KEY --rpc-url http://executor.astria.localdev.me src/Weth9.sol:WETH9
```

* Uniswap v3 contracts
  w/ custom deploy-v3 scripts

```bash
# clone astria's fork of deploy-v3
git clone https://github.com/astriaorg/deploy-v3
cd deploy-v3

# create .env file and fill it with envars you see in the command below. you don't have to use dotenv, but it's convenient.
# NOTE - the private key here requires a prefix of "0x"
touch .env

# NOTE - make sure to delete state.json between restarts of your chain!
rm state.json

# call command with dotenv
dotenv -- bash -c 'yarn start -pk $PRIVATE_KEY \
  -j $JSON_RPC \
  -w9 $WETH9_ADDRESS \
  -ncl $NATIVE_CURRENCY_LABEL \
  -o $OWNER_ADDRESS \
  -c $CONFIRMATIONS'
```

w/ forge

```bash
# installs base64-sol.
# there is a map in foundry.toml that maps "base64-sol" to the node module directory.
pnpm install

dotenv -- bash -c 'forge script script/DeployUniswapV3.s.sol:DeployUniswapV3 \
  --optimizer-runs 2 \
  --private-key $PRIVATE_KEY \
  --rpc-url $JSON_RPC \
  --chain-id 912559 \
  --slow \
  --broadcast --skip-simulation -vvvvv'
```

* ERC-20

```bash
# deploy AstriaToken
RUST_LOG=debug forge create --private-key $PRIV_KEY --rpc-url http://executor.astria.localdev.me src/AstriaToken.sol:AstriaToken

# deploy SteezeToken
RUST_LOG=debug forge create --private-key $PRIV_KEY --rpc-url http://executor.astria.localdev.me src/SteezeToken.sol:SteezeToken
```

## Tests

```bash
forge test --rpc-url http://executor.astria.localdev.me -vvvvv
```

## Gotchas

There are a few weird things that you may run into when using this repo.

* Multiple versions openzeppelin-contracts
  * The Uniswap contracts require an older version of openzeppelin-contracts, but the Astria contracts use a newer version of openzeppelin-contracts.
  * This is why there are two versions of openzeppelin-contracts in the foundry.toml file.
* `base64-sol` is installed via `npm` and importable because of the remappings in foundry.toml

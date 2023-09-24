## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Project creation

```shell
$ forge init --force
```

Definir versão solidity no foundry.toml

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```


### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge create --verify --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/Counter.sol:Storage
```

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

```shell
cast abi-encode "constructor(string,string,uint8,uint256)"
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

# Ambiente de Desenvolvimento

## VSCode

### Plugin para Solidity

[https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

### Documentation

https://book.getfoundry.sh/

### Instalação do Foundry Forge no Windows

https://dev.to/oleanji/installing-foundry-toolchain-on-windows-27ml

### Criação do projeto Forge

Depois de fazer o clone do repositório remoto na maquina local de desenvolvimento, execute:

```shell
$ forge init --force
```

Definir versão solidity no foundry.toml

### Uso

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

### Import external Libs

forge install é o comando usado para instalar dependencias/bibliotecas. Use forge install  {{github_username}}/{{repo_name}} da URL do github do projeto, por exemplo:

```shell
$ forge install Openzeppelin/openzeppelin-contracts
```

IMPORTANTE: seu projeto não pode ter nada pendente de commitar pois por baixo dos panos o forge irá instalar submodulos git no seu projeto.

Depois, para permitir que o plugin de Solidity do VSCode detecte corretamente a biblioteca, faça o remapping. Exemplo:

```shell
$ forge remappings > remappings.txt
```

Ou execute o forge remappings, pegue o conteúdo que sair no terminal e gere o arquivo remappings.txt manualmente e salve na raiz do projeto.

### Deploy

```shell
$ forge create --verify --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/Counter.sol:Storage
```

```shell
$ forge create --verify --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $RPC_URL --private-key $PRIVATE_KEY Exercicio
```

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url $RPC_URL  --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

```shell
$ cast call YOUR_CONTRACT_ADDRESS "number()" --rpc-url $RPC_URL
```

```shell
$ cast send YOUR_CONTRACT_ADDRESS "setNumber(uint256)" 10 --rpc-url $RPC_URL  --private-key $PRIVATE_KEY
```


```shell
$ cast abi-encode "constructor(string,string,uint8,uint256)"
```

```shell
$ cast --from-wei 300000000000000000
```

```shell
$ cast --from-ascii '<str>'
```

```shell
$ cast interface  < address > --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## Backend: node + ethers.js

### Iniciando projeto

Assumindo que o projeto de backend ficará dentro do subdiretório `backend`...

```shell
$ yarn init
$ yarn add dotenv ethers
```

Gerar ABI do contrato ExercicioToken no Remix, criar o arquivo token-abi.json e salvar o conteúdo ABI neste arquivo.

Depois seguir as instruções no arquivo index.js

## Frontend: ethers.js + Metamask

Assumindo que o projeto de backend ficará dentro do subdiretório `frontend`...

Copiar o arquivo token-abi.json (ABI do contrato ExercicioToken) do diretório do `backend`, eles serão o mesmo pois apontaremos para o mesmo contrato.
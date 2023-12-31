require("dotenv").config();
const { ethers } = require("ethers");

const ABI = require("./token-abi.json");
const ABIHelper = new ethers.Interface(ABI);
const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
const signer = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contractAddress = "0x89A2E711b2246B586E51f579676BE2381441A0d0";
const contractReadMode = new ethers.Contract(contractAddress, ABI, provider);
const contractReadWriteMode = new ethers.Contract(contractAddress, ABI, signer);

async function getAddressSigner() {
  const address = await signer.address;
  console.log("O endereço do signer é:", address);
  return address;
}

async function getBalance(contaCliente) {
  const saldo = await contractReadMode.balanceOf(contaCliente);
  console.log("Saldo do cliente: ", contaCliente, "é", saldo);
}

async function getNomeToken() {
  const nome = await contractReadMode.name();
  console.log("Nome do Token é: ", nome);
}

async function getTodasTransferenciasParaUmCliente(contaCliente) {
  const from = [];
  const filter = contractReadMode.filters.Transfer(from, contaCliente);
  const events = await contractReadMode.queryFilter(filter);
  console.log("Um total de ", events.length," transações foram encontradas.");
  events.forEach( (evento) => parseLogTransferencia(evento)); 
}

function parseLogTransferencia(evento) {
  const parsedLog = ABIHelper.parseLog(evento);
  console.log("Evento de Transferencia Parseado:", parsedLog);
}

async function getLogTransferencia(contaCliente, bloco) {
  const from = [];
  const filter = contractReadMode.filters.Transfer(from, contaCliente);
  const events = await contractReadMode.queryFilter(filter, bloco);
  events.forEach( (evento) => {
    parseLogTransferencia(evento);
  }); 
}

async function obterMaisTokens(contaCliente) {
  console.log("Preparando transação...");
  const tx = await contractReadWriteMode.mint(contaCliente, 100000n);
  console.log("Tx enviada ao transaction pool da rede blockchain. TxHash:", tx.hash);
  const txReceipt = await tx.wait(1);
  if (txReceipt.status != 1) {
    console.error(`Falha na transação ${tx}`);
    return
  }
  console.log("Transacao de mint realizada com sucesso!");
  console.log("Detalhes: ", txReceipt);
  await getLogTransferencia(contaCliente, txReceipt.blockNumber);
}

async function main() {
  try {
    await getBalance("0xd288e4cF07d4Fef601e79eB1f32809DbcBd3C440"); 
    await getNomeToken();
    signerAddress = await getAddressSigner();
    await getBalance(signerAddress); 
    await obterMaisTokens(signerAddress)
    await getBalance(signerAddress); 
    await getTodasTransferenciasParaUmCliente(signerAddress);
  } catch (error) {
    console.log('Erro no processamento: ', error );
  }
}

main().then( () => process.exit(0) )

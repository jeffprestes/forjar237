require("dotenv").config();
const { ethers } = require("ethers");

const ABI = require("./token-abi.json");
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
    await getNomeToken();
    signerAddress = await getAddressSigner();
    await getBalance(signerAddress); 
    await obterMaisTokens(signerAddress)
    await getBalance(signerAddress); 
    // await getTodasTransferenciasParaUmCliente(signerAddress);
  } catch (error) {
    console.log('Erro no processamento: ', error );
  }
}

main().then( () => process.exit(0) )

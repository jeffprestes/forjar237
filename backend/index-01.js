require("dotenv").config();
const { ethers } = require("ethers");

const ABI = require("./token-abi.json");
const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
const contractAddress = "0x89A2E711b2246B586E51f579676BE2381441A0d0";
const contractReadMode = new ethers.Contract(contractAddress, ABI, provider);

async function getBalance(contaCliente) {
  const saldo = await contractReadMode.balanceOf(contaCliente);
  console.log("Saldo do cliente: ", contaCliente, "é", saldo);
}

async function getNomeToken() {
  const nome = await contractReadMode.name();
  console.log("Nome do Token é: ", nome);
}


async function main() {
  try {
    await getNomeToken();
    await getBalance("0xd288e4cF07d4Fef601e79eB1f32809DbcBd3C440"); 
  } catch (error) {
    console.log('Erro no processamento: ', error );
  }
}

main().then( () => process.exit(0) );
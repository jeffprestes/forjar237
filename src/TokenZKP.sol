/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.19;

import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";
import { Groth16Verifier } from "./ValidaCliente.sol";

/// @title Manages the contract owner
contract Owned {
    address payable contractOwner;

    modifier onlyOwner() {
        require(msg.sender == contractOwner, "only owner can perform this operation");
        _;
    }

    constructor() { 
        contractOwner = payable(msg.sender); 
    }
    
    function whoIsTheOwner() public view returns(address) {
        return contractOwner;
    }

    function changeOwner(address _newOwner) onlyOwner public returns (bool) {
        require(_newOwner != address(0x0), "only valid address");
        contractOwner = payable(_newOwner);
        return true;
    }
    
}


/// @title ERC-20 Token template
contract ExercicioTokenZKP is IERC20Metadata, Owned {
    string private myName;
    string private mySymbol;
    uint256 private myTotalSupply;
    uint8 private myDecimals;
    Groth16Verifier public validador;

    mapping (address=>uint256) balances;
    mapping (address=>mapping (address=>uint256)) ownerAllowances;

    modifier hasEnoughBalance(address owner, uint amount) {
        uint balance;
        balance = balances[owner];
        require (balance >= amount); 
        _;
    }

    modifier isAllowed(address spender, address tokenOwner, uint amount) {
        require (amount <= ownerAllowances[tokenOwner][spender]);
        _;
    }

    modifier tokenAmountValid(uint256 amount) {
        require(amount > 0);
        require(amount <= myTotalSupply);
        _;
    }    

    constructor() {
        myName = "Exercicio Token ZKP";
        mySymbol = "ZKPEXCT";
        myDecimals = 2;
        validador = Groth16Verifier(0x5C410cBCE00A623ee54f85C19BFE80d37B0c11D0);
    }

    function name() public view returns(string memory) {
        return myName;
    }

    function symbol() public view returns(string memory) {
        return mySymbol;
    }

    function totalSupply() public override view returns(uint256) {
        return myTotalSupply;
    }

    function decimals() public override view returns (uint8) {
        return myDecimals;
    }

    function balanceOf(address tokenOwner) public override view returns(uint256) {
        return balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public override view returns(uint256) {
        return ownerAllowances[tokenOwner][spender];
    }

    function transfer(address to, uint256 amount) 
    public 
    override  
    hasEnoughBalance(msg.sender, amount) 
    tokenAmountValid(amount) 
    returns (bool) 
    {
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[to] = balances[to] + amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    } 

    function approve(address spender, uint limit) public override returns(bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        ownerAllowances[msg.sender][spender] = limit;
        emit Approval(msg.sender, spender, limit);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override 
    hasEnoughBalance(from, amount) isAllowed(msg.sender, from, amount) tokenAmountValid(amount)
    returns(bool) {
        balances[from] = balances[from] - amount;
        balances[to] += amount;
        ownerAllowances[from][msg.sender] = amount;
        emit Transfer(from, to, amount);
        return true;
    }
    
    function mint(
        address account, 
        uint256 amount,
        uint[2] calldata _pA,
        uint[2][2] calldata _pB,
        uint[2] calldata _pC,
        uint[1] calldata _pubSignals
        ) public returns (bool) {
        require(account != address(0), "ERC20: mint to the zero address");
        require(validador.verifyProof(_pA, _pB, _pC, _pubSignals), "Somente cliente");

        myTotalSupply = myTotalSupply + amount;
        balances[account] = balances[account] + amount;
        emit Transfer(address(0), account, amount);
        return true;
    }

    function burn(address account, uint256 amount) public returns (bool) {
        require(account != address(0), "ERC20: burn from address");
        require(msg.sender == account || msg.sender == contractOwner, "you are not allowed to burn");
        balances[account] = balances[account] - amount;
        myTotalSupply = myTotalSupply - amount;
        emit Transfer(account, address(0), amount);
        return true;
    }
}
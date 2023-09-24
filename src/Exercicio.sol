// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./bradesco_token_aberto.sol";

contract Exercicio {

    ExercicioToken token;
    string public nomeCliente;

    constructor() {
        token = ExercicioToken(0x89A2E711b2246B586E51f579676BE2381441A0d0);
        nomeCliente = "Jose Maria";
    }

    function Saldo(address _quem) public view returns(uint256) {
        return token.balanceOf(_quem);
    }

    function gereToken(address _quem, uint256 _qtde) external {
        token.mint(_quem, _qtde);
    }

    function MeuSaldo() public view returns(uint256) {
        return Saldo(address(this));
    }

    function GerarTokenParaEuCliente(uint256 _qtde) public {
        token.mint(address(this), _qtde);
    }

}
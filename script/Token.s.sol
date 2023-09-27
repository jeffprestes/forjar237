// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";
import {ExercicioToken} from "../src/Token.sol";

contract TokenScript is Script {

    ExercicioToken token;

    function setUp() public {
      token = ExercicioToken(0x3e94d431157e857ce269746471eeb9b098b73aa3);
    }

    function run() public {
        vm.startBroadcast();
        console2.log("%s meu saldo eh %s", msg.sender, token.balanceOf(msg.sender));
        token.mint(msg.sender, 1 ether);
        console2.log("%s meu saldo eh %s", msg.sender, token.balanceOf(msg.sender));
        vm.stopBroadcast();
    }
}

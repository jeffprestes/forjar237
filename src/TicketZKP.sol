// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/contracts/utils/Counters.sol";
import { Groth16Verifier } from "./ValidaCliente.sol";


contract LollaZKP is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("LollaZKP", "LZKP") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}

/*
0x0215AEeC6D0654171f295587EA8F3fAeCAFCf0e6

[   "0x0bac22cc4eb79cab104521114a987c5604b9c8f1597fe4e3d457c96b104627de", "0x166207bed12acd3c2d0b1b64c7cd4ec8269dd3479f5b9315ffae4a3b3e2a52d1" ]

[   [     "0x1c307739a26eb86bc5b43e1b90d7687834ef57061addb521d9ea80352059dc24", "0x1b52a653e7b2de0a148186ce5703197f7e9f486f67a7fdd323a5b14617833188"   ],   [     "0x2cf426e929c4443662ab0c12118d86da4d1c625b967bab01c49f600c6ccb6da4", "0x0d0b6569d29014e4cfca0b67a872c46ab922ed0890e25832b3b5d9d875404f7d"   ] ]

[   "0x2df836ec29869befc9f4476a6a67353d48db5e7a61c17eb567983ce98d1de4cb", "0x2ac53450267b4b2bf6242f2f12ad56f4b2593bd6a6f3855204be9a2ca59563f7" ]

[   "0x000000000000000000000000000000000000000000000000000000000009ac9c" ]
*/
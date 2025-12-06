// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract ERC721demo is ERC721, Ownable {
    mapping(string => uint256) private cidToTokenIdMap;
    mapping(uint256 => string) private tokenIdToCidMap;

    constructor(
        address owner_,
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) Ownable(owner_) {}

    //产生NTF
    function mintNTF(uint256 tokenId, string memory cid) external onlyOwner {
        require(tokenId > 0);
        bytes memory cidBytes = bytes(cid);
        require(cidBytes.length > 0);
        cidToTokenIdMap[cid] = tokenId;
        tokenIdToCidMap[tokenId] = cid;
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        _requireOwned(tokenId);
        return tokenIdToCidMap[tokenId];
    }
}

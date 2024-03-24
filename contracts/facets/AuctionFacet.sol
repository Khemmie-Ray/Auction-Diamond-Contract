// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import "../interfaces/IERC721.sol";

contract AuctionFacet {
    LibAppStorage.ERC20AppStorage internal s;
    LibAppStorage.Auction internal x;

    event AuctionCreated(bool success);
    

    function createAuction(uint256 _duration,uint256 _tokenId, uint256 _startingPrice) external {
      require(block.timestamp > _duration,  "Invalid duration time");
      require(_startingPrice > 1, "Invalid bid price");
      require(IERC721(s.nftContract).ownerOf(_tokenId) != msg.sender, "Not the owner!");

      uint _newId = s.auctionindex + 1;
      
      LibAppStorage.Auction storage a = s.totalAuctions[_newId];

        a.auctionId = _newId;
        a.duration = _duration;
        a.startingPrice= _startingPrice;
        a.tokenId = _tokenId;
        a.creator = msg.sender;

        s.auctionindex = s.auctionindex + 1;

        IERC721(s.nftContract).safeTransferFrom(msg.sender, address(this), _tokenId);
    }

    function bid(uint _value, uint _tokenId) external {
        require(_value > 0, "Zero value not accepted");
        require(_value > x.startingPrice, "Bid less than starting price");

        if(block.timestamp > x.duration) {
            x.closed = true;
        }
    }

    
}

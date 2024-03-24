// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import "../interfaces/IERC721.sol";

contract AuctionFacet {
    LibAppStorage.ERC20AppStorage internal s;
    event AuctionCreated(bool success);

    function createAuction(
        address _nftContract,
        uint256 _tokenId,
        uint256 _startingPrice,
        uint256 _closeTime
    ) external {
      
        

       
    }

    
}

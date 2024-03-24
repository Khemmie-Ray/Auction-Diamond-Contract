// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

library LibAppStorage {
    
    uint256 constant APY = 120;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

struct Auction {
    uint auctionId;
    address creator;
    uint duration;
    uint tokenId;
    uint startingPrice;
    uint closingPrice;
    uint closeTime;
    bool closed;
}

struct Bid {
    address bidder;
    uint amount;
    uint auctionId;
}

struct ERC20AppStorage {
    mapping(address => uint256)  _balances;
    mapping(address => mapping(address => uint256))  _allowances;

    uint256  _totalSupply;
    string  _name;
    string  _symbol;
    uint8 _decimal;

    uint auctionindex;
    address nftContract;
    address lastBidder;
    mapping(uint => Auction) totalAuctions;
}

function layoutStorage() internal pure returns (ERC20AppStorage storage l) {
    assembly {
        l.slot := 0
    }
}

 function _transferFrom(address _from, address _to, uint256 _amount) internal {
        ERC20AppStorage storage s = layoutStorage();
        uint256 frombalances = s._balances[_from]; 

        require(
            frombalances >= _amount,
            "ERC20: Not enough tokens to transfer"
        );
        s._balances[_from] = frombalances - _amount;
        s._balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
    }
}
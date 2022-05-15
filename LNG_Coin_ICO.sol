// LNGCoin ICO 

// Version of Compiler
pragma solidity ^0.8.7;

contract lngcoin_ico {

    // Introducing the maximum number of LNGCoins avaiable for sale 
    uint public max_lngcoin = 1000000;

    // Introducing the USD to LNGCoin conversion rate
    uint public usd_to_lngcoins = 100;

    // Introducing the total number of LNGCoins bought by investors 
    uint public total_lngcoins_bought = 0;

    // Mapping form the investors address to its equity in LNGCoins and USD
    mapping(address => uint) equity_lngcoin;
    mapping(address => uint) equity_usd;

    // Check if any of LNGCoins left
    modifier can_buy_lngcoins(uint usd_invested) {
        require(usd_invested * usd_to_lngcoins + total_lngcoins_bought <= max_lngcoin);
        _;
    }

    // Get the equity in LNG Coins of Investors
    function equity_in_lngcoin(address investor) external view returns (uint) { 
        return equity_lngcoin[investor];
    }

    // Getting the equity in USD of the investors
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Buying LNG Coins
    function buy_lngcoins(address investor, uint usd_invested) external 
    can_buy_lngcoins(usd_invested) {
        uint lngcoins_bought = usd_invested * usd_to_lngcoins;
        equity_lngcoin[investor] += lngcoins_bought;
        equity_usd[investor] = equity_lngcoin[investor] / 100;
        total_lngcoins_bought += lngcoins_bought;
    }

    // Selling LNG Coins
    function sell_lngcoins(address investor, uint lngcoins_sold) external {
        equity_lngcoin[investor] -= lngcoins_sold;
        equity_usd[investor] = equity_lngcoin[investor] / 100;
        total_lngcoins_bought -= lngcoins_sold;
    }

}  


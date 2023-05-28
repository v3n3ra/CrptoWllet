//
//  Coin.swift
//  CrptoWllet
//
//  Created by V K on 22.05.2023.
//

import UIKit

struct Coin {
    
    let name:            String
    let symbol:          String
    let priceUsd:        Double
    let pctChange1h:     Double
    let pctChange24h:    Double
    let rank:            Int
    let marketCap:       Double
    let marketDominance: Double
    let supply:          Double
    let volume24h:       Double
    let high1h:          Double
    let high24h:         Double
    
    init(coin: CoinData) {
        name = coin.data.name
        symbol = coin.data.symbol
        priceUsd = coin.data.marketData.priceUsd
        pctChange1h = coin.data.marketData.percentChangeUsdLast1Hour
        pctChange24h = coin.data.marketData.percentChangeUsdLast24Hours
        rank = coin.data.marketCap.rank
        marketCap = coin.data.marketCap.currentMarketcapUsd
        marketDominance = coin.data.marketCap.marketcapDominancePercent
        supply = coin.data.supply.circulating
        volume24h = coin.data.marketData.volumeLast24Hours
        high1h = coin.data.marketData.ohlcvLast1Hour.high
        high24h = coin.data.marketData.ohlcvLast24Hour.high
    }
    
}

//
//  CoinData.swift
//  CrptoWllet
//
//  Created by V K on 16.04.2023.
//

import Foundation

// MARK: - CoinData

struct CoinData: Decodable {
    
    let data : Data
    
    // MARK: - Data
    
    struct Data : Decodable {
        
        let id, symbol, name          : String
        let marketData                : MarketData
        let marketCap                 : MarketCap
        let supply                    : Supply
        
        enum CodingKeys: String, CodingKey {
            case id, symbol, name
            case marketData               = "market_data"
            case marketCap                = "marketcap"
            case supply
        }
        
    }
    
}


import Foundation

struct MarketCap: Decodable {
    
    let rank                             : Int
    let marketcapDominancePercent        : Double
    let currentMarketcapUsd              : Double
    
    enum CodingKeys: String, CodingKey {
        
        case rank
        case marketcapDominancePercent        = "marketcap_dominance_percent"
        case currentMarketcapUsd              = "current_marketcap_usd"
        
    }
    
}

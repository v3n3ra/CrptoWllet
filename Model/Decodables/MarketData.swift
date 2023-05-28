
import Foundation

struct MarketData: Decodable {

    let priceUsd                               : Double
    let volumeLast24Hours                      : Double
    let percentChangeUsdLast1Hour              : Double
    let percentChangeUsdLast24Hours            : Double
    let ohlcvLast1Hour                         : OhlcvLast1Hour
    let ohlcvLast24Hour                        : OhlcvLast24Hour
    
    enum CodingKeys: String, CodingKey {
        
        case priceUsd                               = "price_usd"
        case volumeLast24Hours                      = "volume_last_24_hours"
        case percentChangeUsdLast1Hour              = "percent_change_usd_last_1_hour"
        case percentChangeUsdLast24Hours            = "percent_change_usd_last_24_hours"
        case ohlcvLast1Hour                         = "ohlcv_last_1_hour"
        case ohlcvLast24Hour                        = "ohlcv_last_24_hour"
    }
    
}

//
//  CoinViewModel.swift
//  CrptoWllet
//
//  Created by V K on 23.05.2023.
//

import UIKit

struct CoinViewModel {
    
    private let coin: Coin
    
    let pctChange1h: Double
    let pctChange24h: Double
    
    // MARK: - Formatted Properties
    
    var name: String {
        coin.name
    }
    
    var symbol: String {
        coin.symbol
    }
    
    var price: String {
        format(coin.priceUsd, dropDecimals: false)
    }
    
    var rank: String {
        "\(coin.rank)"
    }
    
    var marketCap: String {
        format(coin.marketCap)
    }
    
    var marketDominance: String {
        String(format: "%.2f", coin.marketDominance) + "%"
    }
    
    var supply: String {
        format(coin.supply)
    }
    
    var volume24h: String {
        format(coin.volume24h)
    }
    
    var high1h: String {
        format(coin.high1h, toDigits: 5)
    }
    
    var high24h: String {
        format(coin.high24h, toDigits: 5)
    }
    
    // MARK: - Init
    
    init(coin: Coin) {
        self.coin = coin
        pctChange1h = coin.pctChange1h
        pctChange24h = coin.pctChange24h
    }
    
    // MARK: - Methods
    
    func makePctChangeLabel(for value: Double) -> String {
        value.description.first == "-" ? "\(String(format: "%.2f", value))%" : "+\(String(format: "%.2f", value))%"
    }
    
    func estimateColor(for label: UILabel) -> UIColor {
        label.text?.first == "+" ? UIColor(hex: "0E8C0C") ?? .green : .red
    }
    
    private func format(_ value: Double, dropDecimals: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        guard let formattedValue = formatter.string(from: NSNumber(value: value)) else { return "" }
        
        if dropDecimals {
            return String(formattedValue.dropLast(3))
        } else {
            return formattedValue
        }
    }
    
    private func format(_ value: Double, toDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = toDigits
        
        guard let formattedValue = formatter.string(from: NSNumber(value: value)) else { return "" }
        
        return "$\(formattedValue)"
    }
    
}

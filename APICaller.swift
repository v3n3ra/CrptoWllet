//
//  APICaller.swift
//  CrptoWllet
//
//  Created by V K on 16.04.2023.
//

import Foundation

struct Constants {
    
    fileprivate static let baseURL = "https://data.messari.io/api/v1/assets/"
    fileprivate static let path = "/metrics"
    
    enum Coins: String, CaseIterable {
        case btc
        case eth
        case tron
        case polkadot
        case dogecoin
        case tether
        case stellar
        case cardano
        case xrp
    }
    
}

final class APICaller {
    
    static let shared = APICaller()
    
    func loadCoinInfo(coin: Constants.Coins,
                      completion: @escaping (Result<CoinData, Error>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)\(coin.rawValue)\(Constants.path)") else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { completion(.failure(APIError.serverError)); return }
            
            do {
                let result = try JSONDecoder().decode(CoinData.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

enum APIError: Error {
    case serverError
}

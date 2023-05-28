//
//  MainViewModel.swift
//  CrptoWllet
//
//  Created by V K on 16.04.2023.
//

import UIKit

protocol MainViewModelProtocol {
    var stateDidChange: ((ViewModelState) -> Void)? { get set }
    var coins: [CoinViewModel] { get }
    var isErrorLabelHidden: Bool { get }
    func getAllCoins()
    func reloadData()
    func sortByPctChange(isAscending: Bool)
    func performLoggingOut()
}


enum ViewModelState {
    case loading
    case loaded
    case error(Error)
}

final class MainViewModel: MainViewModelProtocol {
    
    var stateDidChange: ((ViewModelState) -> Void)?

    var coins: [CoinViewModel] = [] {
        didSet {
            stateDidChange?(.loaded)
        }
    }
    
    var isErrorLabelHidden: Bool = true
    
    // MARK: - Methods
    
    func getAllCoins() {
        stateDidChange?(.loading)
        isErrorLabelHidden = true

        let dispatchGroup = DispatchGroup()
        var coinsByRank: [Coin] = []
        var errors: [Error] = []

        Constants.Coins.allCases.forEach { coin in
            dispatchGroup.enter()
            APICaller.shared.loadCoinInfo(coin: coin) { result in
                defer {
                    dispatchGroup.leave()
                }
                switch result {
                case .success(let coinData):
                    DispatchQueue.main.async {
                        coinsByRank.append(Coin(coin: coinData))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        errors.append(error)
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            if !errors.isEmpty || coinsByRank.isEmpty {
                self?.stateDidChange?(.error(APIError.serverError))
                self?.isErrorLabelHidden = false
            } else {
                coinsByRank.sort { $0.rank < $1.rank }
                self?.coins = coinsByRank.map { CoinViewModel(coin: $0) }
                self?.stateDidChange?(.loaded)
                self?.isErrorLabelHidden = true
            }
        }
    }
    
    func reloadData() {
        coins.removeAll()
        getAllCoins()
    }
    
    func sortByPctChange(isAscending: Bool) {
        coins.sort(by: { isAscending ? $0.pctChange24h < $1.pctChange24h : $0.pctChange24h > $1.pctChange24h } )
    }
    
    func performLoggingOut() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(to: .loggedOut)
        }
    }
    
}

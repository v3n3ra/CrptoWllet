//
//  CoinDetailView.swift
//  CrptoWllet
//
//  Created by V K on 14.05.2023.
//

import UIKit
import SnapKit

final class CoinDetailView: UIView {
    
    //MARK: - UI Elements
    
    private let symbol: UIImageView    = Reusable.symbolImage(width: UIConstants.w/8)
    private let rankLabel: UILabel     = Reusable.rankLabel()
    private let nameLabel: UILabel     = Reusable.label(textColor: .darkGray)
    private let priceUsdLabel: UILabel = Reusable.label(font: UIConstants.w/17)
    
    private let marketDominanceLabel: UILabel = Reusable.label(weight: .semibold)
    private let marketCapLabel: UILabel       = Reusable.label(weight: .semibold)
    private let supplyLabel: UILabel          = Reusable.label(weight: .semibold)
    private let volume24hLabel: UILabel       = Reusable.label(weight: .semibold)
    private let high1hLabel: UILabel          = Reusable.label(weight: .semibold)
    private let high24hLabel: UILabel         = Reusable.label(weight: .semibold)
    private let pctChange1hLabel: UILabel     = Reusable.pctLabel()
    private let pctChange24hLabel: UILabel    = Reusable.pctLabel()
    
    private let marketCapTitleLabel: UILabel       = Reusable.label(text: "Market Cap")
    private let marketDominanceTitleLabel: UILabel = Reusable.label(text: "Market Dominance")
    private let supplyTitleLabel: UILabel          = Reusable.label(text: "Circulating Supply")
    private let volume24hTitleLabel: UILabel       = Reusable.label(text: "Volume 24h")
    private let high1hTitleLabel: UILabel          = Reusable.label(text: "High 1h")
    private let high24hTitleLabel: UILabel         = Reusable.label(text: "High 24h")

    // main stack
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalSubStack,
                                                       marketCapStack,
                                                       marketDominanceStack,
                                                       supplyStack,
                                                       volume24hStack,
                                                       high1hStack,
                                                       high24hStack])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        
        return stackView
    }()
    
    // vertical sub stack
    private lazy var verticalSubStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbol,
                                                       rankLabel,
                                                       nameLabel,
                                                       priceUsdLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        
        return stackView
    }()
    
    // horizontal sub stacks
    private lazy var marketCapStack: UIStackView       = Reusable.hStack(marketCapTitleLabel, marketCapLabel)
    private lazy var marketDominanceStack: UIStackView = Reusable.hStack(marketDominanceTitleLabel, marketDominanceLabel)
    private lazy var supplyStack: UIStackView          = Reusable.hStack(supplyTitleLabel, supplyLabel)
    private lazy var volume24hStack: UIStackView       = Reusable.hStack(volume24hTitleLabel, volume24hLabel)
    private lazy var high1hStack: UIStackView          = Reusable.hStack(high1hTitleLabel, high1hLabel, pctChange1hLabel)
    private lazy var high24hStack: UIStackView         = Reusable.hStack(high24hTitleLabel, high24hLabel, pctChange24hLabel)
    
    //MARK: - Init
    
    init(coin: CoinViewModel) {
        super.init(frame: .zero)
        
        configure(with: coin)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with methods

private extension CoinDetailView {
    
    func layout() {
        verticalSubStack.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.h/4.5)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w*0.85)
            make.height.greaterThanOrEqualToSuperview().dividedBy(3)
            make.center.equalToSuperview()
        }
    }
    
    func configure(with coin: CoinViewModel) {
        rankLabel.text = coin.rank
        symbol.image = UIImage(named: coin.symbol)
        nameLabel.text = coin.name
        priceUsdLabel.text = coin.price
        marketCapLabel.text = coin.marketCap
        marketDominanceLabel.text = coin.marketDominance
        supplyLabel.text = coin.supply
        volume24hLabel.text = coin.volume24h
        high1hLabel.text = coin.high1h
        high24hLabel.text = coin.high24h
        pctChange1hLabel.text = coin.makePctChangeLabel(for: coin.pctChange1h)
        pctChange24hLabel.text = coin.makePctChangeLabel(for: coin.pctChange24h)
        pctChange1hLabel.textColor = coin.estimateColor(for: pctChange1hLabel)
        pctChange24hLabel.textColor = coin.estimateColor(for: pctChange24hLabel)
        pctChange1hLabel.layer.shadowColor = coin.estimateColor(for: pctChange1hLabel).cgColor
        pctChange24hLabel.layer.shadowColor = coin.estimateColor(for: pctChange24hLabel).cgColor
    }
    
}

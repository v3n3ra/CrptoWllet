//
//  CoinTableViewCell.swift
//  CrptoWllet
//
//  Created by V K on 10.05.2023.
//

import UIKit
import SnapKit

final class CoinTableViewCell: UITableViewCell {
    
    static let identifier = "CoinTableViewCell"
    
    // MARK: - UI Elements
    
    private let rankLabel: UILabel         = Reusable.rankLabel()
    private let symbolImage: UIImageView   = Reusable.symbolImage(width: UIConstants.w/11)
    private let symbolLabel: UILabel       = Reusable.label(font: UIConstants.w/30, weight: .bold)
    private let priceLabel: UILabel        = Reusable.label()
    private let dayPctChangeLabel: UILabel = Reusable.pctLabel(withPlate: false)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel,
                                                       symbolImage,
                                                       symbolLabel,
                                                       priceLabel,
                                                       dayPctChangeLabel])
        stackView.axis = .horizontal
        stackView.spacing = UIConstants.w/25
        stackView.setCustomSpacing(UIConstants.w/11, after: rankLabel)
        stackView.setCustomSpacing(UIConstants.w/10, after: priceLabel)
        
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    
    func configure(with coin: CoinViewModel) {
        rankLabel.text = coin.rank
        symbolImage.image = UIImage(named: coin.symbol)
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.price
        dayPctChangeLabel.text = coin.makePctChangeLabel(for: coin.pctChange24h)
        dayPctChangeLabel.textColor = coin.estimateColor(for: dayPctChangeLabel)
    }
    
}

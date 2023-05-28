//
//  HeaderView.swift
//  CrptoWllet
//
//  Created by V K on 15.05.2023.
//

import UIKit

protocol HeaderViewDelegate: UIViewController {
    func sortButtonTapped()
}


final class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - UI Elements
    
    private let rankLabel: UILabel         = Reusable.label(text: "#", font: UIConstants.w/27, textColor: .white)
    private let currencyLabel: UILabel     = Reusable.label(text: "Currency", font: UIConstants.w/27, textColor: .white)
    private let priceLabel: UILabel        = Reusable.label(text: "Price", font: UIConstants.w/27, textColor: .white)
    private let dayPctChangeLabel: UILabel = Reusable.label(text: "24h", font: UIConstants.w/27, textColor: .white)
    
    private let pctSortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel,
                                                       currencyLabel,
                                                       priceLabel,
                                                       dayPctChangeLabel,
                                                       pctSortButton])
        stackView.axis = .horizontal
        stackView.setCustomSpacing(UIConstants.w/4.3, after: currencyLabel)
        stackView.setCustomSpacing(UIConstants.w/7, after: priceLabel)
        stackView.setCustomSpacing(2, after: dayPctChangeLabel)
        
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extension with methods

private extension HeaderView {
    
    @objc func sortButtonTapped() {
        delegate?.sortButtonTapped()
    }
    
    func setupView() {
        // rounded upper corners
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds,
                                       byRoundingCorners: [.topLeft, .topRight],
                                       cornerRadii: CGSize(width: UIConstants.cornerRad, height: UIConstants.cornerRad)).cgPath
        layer.mask = shapeLayer
        
        // gradient background
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(hex: "412814")?.cgColor ?? UIColor.brown.cgColor,
                           UIColor(hex: "2d4a58")?.withAlphaComponent(0.9).cgColor ?? UIColor.cyan.cgColor]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        layer.cornerRadius = UIConstants.cornerRad
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 12))
        }
    }
    
}

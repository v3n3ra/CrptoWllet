//
//  CoinDetailViewController.swift
//  CrptoWllet
//
//  Created by V K on 15.05.2023.
//

import UIKit

final class CoinDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private let coin: CoinViewModel
    private var detailView: CoinDetailView?
    
    //MARK: - Init
    
    init(coin: CoinViewModel) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // gradient background
        let gradient = Gradient.makeLayer()
        view.layer.insertSublayer(gradient, at: .zero)
        
        detailView = CoinDetailView(coin: coin)
        
        configureBackButton()
    }
    
    // to prevent coinstraints conflict
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layout()
    }
    
}

//MARK: - Extension with methods

private extension CoinDetailViewController {
    
    func layout() {
        if let detailView = detailView {
            view.addSubview(detailView)
            detailView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func configureBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK: - Obj-C
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

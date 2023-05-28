//
//  CoinsViewController.swift
//  CrptoWllet
//
//  Created by V K on 19.04.2023.
//

import UIKit

final class CoinsViewController: UIViewController {
    
    var vm: MainViewModelProtocol
    
    // for the sort button
    private var isAscending: Bool = true
    
    // to avoid pushing detail vc twice
    var isPushInProgress: Bool = false
    
    //MARK: - UI Elements
    
    private let errorLabel: UILabel = Reusable.label(text: "Try again",
                                                     font: UIConstants.w/22.5,
                                                     textColor: .darkGray,
                                                     weight: .medium)
    private let tableView = UITableView()
    
    lazy private var activityIndicator = UIActivityIndicatorView()
    
    lazy private var refreshButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh,
                                     target: self,
                                     action: #selector(refreshButtonTapped))
        return button
    }()
    
    lazy private var logotButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Log Out",
                                     style: .plain,
                                     target: self,
                                     action: #selector(logoutButtonTapped))
        return button
    }()
    
    //MARK: - Init
    
    init(vm: MainViewModelProtocol) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTableView()
        configureSubviews()
        configureNavBar()
        
        
        vm.stateDidChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handleVMState(state)
            }
        }
        vm.getAllCoins()
    }
    
    // to disable isPushingInProgress when coming back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isPushInProgress = false
    }
    
    
    //MARK: - Methods
    
    private func handleVMState(_ state: ViewModelState) {
        errorLabel.isHidden = vm.isErrorLabelHidden
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error(let error):
            activityIndicator.stopAnimating()
            print("\(error)")
        }
    }
    
    private func setupTableView() {
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        // gradient background layer
        let gradient = Gradient.makeLayer()
        view.layer.insertSublayer(gradient, at: .zero)
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
        tableView.backgroundView = backgroundView
        
        // layout
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureSubviews() {
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = refreshButton
        navigationItem.rightBarButtonItem = logotButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "2D4A58")
    }
    
    //MARK: - Obj-C
    
    @objc private func refreshButtonTapped() {
        vm.reloadData()
    }
    
    @objc private func logoutButtonTapped() {
        vm.performLoggingOut()
    }
    
}

//MARK: - Extension Header View Delegate

extension CoinsViewController: HeaderViewDelegate {
    
    func sortButtonTapped() {
        isAscending.toggle()
        vm.sortByPctChange(isAscending: isAscending)
        tableView.reloadData()
    }
    
}

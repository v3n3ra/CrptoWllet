//
//  CoinsViewController+Extensions.swift
//  CrptoWllet
//
//  Created by V K on 22.05.2023.
//

import UIKit

//MARK: - Extension Table View Data Source

extension CoinsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(with: vm.coins[indexPath.row])
        return cell
    }
    
}

//MARK: - Extension Table View Delegate

extension CoinsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isPushInProgress else { return }
        
        isPushInProgress = true
        navigationController?.pushViewController(CoinDetailViewController(coin: vm.coins[indexPath.row]), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIConstants.h/12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIConstants.w, height: UIConstants.h/13.5))
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UIConstants.h/13.5
    }
    
}


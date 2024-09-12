//
//  HistoryPageViewController.swift
//  TermProject
//
//  Created by SaiThaw- on 6/9/2567 BE.
//

import UIKit

class HistoryPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: CartItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CartItemTableViewCell.identifier)
    }
}

extension HistoryPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        print("number of sections:", HISTORY.count)
        return HISTORY.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("number of rows in section: " , HISTORY[section].orderList.count)
        return HISTORY[section].orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as! CartItemTableViewCell
        
        let order = HISTORY[indexPath.section].orderList[indexPath.row]
        cell.setup(order)
//        print("cell created for section:", HISTORY[indexPath.section])
//        print("cell detail:", HISTORY[indexPath.section].orderList[indexPath.row] )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView(reuseIdentifier: "HeaderView")
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let dateLabel = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.frame.size.width - 30, height: 30))
        dateLabel.text = dateFormatter.string(from: HISTORY[section].time)
        dateLabel.font = .boldSystemFont(ofSize: 16)
        
        headerView.addSubview(dateLabel)
        
        return headerView
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}

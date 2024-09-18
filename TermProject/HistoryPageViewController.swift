    //
//  HistoryPageViewController.swift
//  TermProject
//
//  Created by SaiThaw- on 6/9/2567 BE.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HistoryPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOrderHistoryFromfirestore()
        tableView.reloadData()
    }
    
    private func fetchOrderHistoryFromfirestore() {
        let db = Firestore.firestore()
        
        HISTORY = []
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: No user logged in")
            return
        }
        
        db.collection("orders")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching order history: \(error)")
            }else{
                guard let documents = querySnapshot?.documents else { return }
                
                for document in documents {
                    let data = document.data()
                    let timestamp = data["time"] as? Timestamp ?? Timestamp(date: Date())
                    let total = data["total"] as? Double ?? 0.0
                    let orderListData = data["orderList"] as? [[String: Any]] ?? []
                    
                    var orderList: [Order] = []
                    
                    for orderData in orderListData {
                        let image = orderData["image"] as? String ?? ""
                        let name = orderData["name"] as? String ?? ""
                        let total = orderData["total"] as? Double ?? 0.0
                        let sweetnessLvl = orderData["sweetnessLvl"] as? String ?? ""
                        let size = orderData["size"] as? String ?? ""
                        let quantity = orderData["quantity"] as? Int ?? 0
                        
                        let order = Order(image: image, name: name, total: total, sweetnessLvl: sweetnessLvl, size: size, quantity: quantity)
                        orderList.append(order)
                    }
                    
                    let orderListObj = OrderList(time: timestamp.dateValue(), total: total, orderList: orderList)
                    HISTORY.append(orderListObj)
                }
                
                self.tableView.reloadData()
            }
        }
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

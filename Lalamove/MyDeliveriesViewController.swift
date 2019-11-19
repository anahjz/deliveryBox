//
//  ViewController.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SVProgressHUD

class MyDeliveriesViewController: UIViewController, ViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    private var refreshControll = UIRefreshControl()
    private var viewModel = MyDeliveriesViewModel()

    private var totalDeliveries = [DeliveryData]()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.refreshControl = refreshControll
        self.refreshControll.addTarget(self, action: #selector(self.refresh(_:)), for: UIControl.Event.valueChanged)
        
        viewModel.delegate = self
        viewModel.getMyDeliveries()
    }
    
    func dataRecieved() {
        
        totalDeliveries.append(contentsOf: viewModel.deliveryDatas )

        tableView.reloadData()
        tableView.isHidden = false
        emptyView.isHidden = true
        refreshControll.endRefreshing()
        
    }
    
    func emptyData() {
        
        tableView.isHidden = false
        emptyView.isHidden = false
    }
    
    
    func progressBarStartAnimating() {
        
        SVProgressHUD.show(withStatus: "in Progress")
        
    }
    
    func progressBarStopAnimating() {

        SVProgressHUD.dismiss()
    }
    
    @objc func refresh(_ refresh: UIRefreshControl) {
        
        viewModel.getMyDeliveries()
        
        
    }
    
    fileprivate func makeShowMoreCell(indexPath:IndexPath)->UITableViewCell? {
        
        return isLoadingIndexPath(indexPath) ? tableView.dequeueReusableCell(withIdentifier: "showMoreCell", for: indexPath as IndexPath) : nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetail"
        {
            let vc = segue.destination as! DeliveryDetailViewController
            vc.delivery = (sender as? DeliveryData) ?? nil
        }
    }
    
}


extension MyDeliveriesViewController: UITableViewDataSource {
    
    fileprivate func isLoadingIndexPath(_ indexPath: IndexPath?) -> Bool {
        
        guard viewModel.shouldShowLoadingCell else { return false }
        return indexPath!.row == self.totalDeliveries.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.shouldShowLoadingCell ? self.totalDeliveries.count + 1 : self.totalDeliveries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == self.totalDeliveries.count && viewModel.shouldShowLoadingCell) {
            
            let  cell = makeShowMoreCell(indexPath: indexPath)
            return cell!
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryCell
    
        cell.delivery = totalDeliveries[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetail", sender: totalDeliveries[indexPath.row])
        
    }
    
}

extension MyDeliveriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
                guard isLoadingIndexPath(indexPath) else { return }
                viewModel.getMyDeliveries()
    }
    
    
}

//
//  MainTableView.swift
//  YanPractice23.03
//
//  Created by admin on 10.04.2023.
//

import UIKit
import Foundation

class MainTableView: UITableViewController, NetworkServiceDelegate {
    
    var selectedIndexPath = IndexPath() // счетчик
    
    let networkService = NetworkService()
    
    let refreshCont = UIRefreshControl()
    
    func didUpdateData() {
        DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshCont.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(refreshCont)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")

        networkService.delegate = self
        networkService.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) { // тут не ясно пока
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .none) // счетчик
        }
    }


    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("countRow: \(networkService.NewsData.count)")
        return min(networkService.NewsData.count, 20)
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath) as? NewsCell
        cell?.incrementCounter()// счетчик
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        let News = networkService.NewsData[indexPath.row]
        
        cell.configure(with: News)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let detailVC = segue.destination as? DetailView,
               let indexPath = tableView.indexPathForSelectedRow {
                let selectedArticle = networkService.NewsData[indexPath.row]
                detailVC.article = selectedArticle

                if let cell = tableView.cellForRow(at: indexPath) as? NewsCell {
                    cell.tapCounter += 1 // счетчик
                }
            }
        }
    }

    
    @objc func refreshTable() {
        networkService.fetchData()
        tableView.reloadData()
        refreshCont.endRefreshing()
        
    }
    
}




//
//  FlightsResultsTableViewController.swift
//  LifeTrip
//
//  Created by Anas Najjar on 08/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class FlightsResultsTableViewController: UITableViewController {

    var results : Array<Result>? = []
    var oneWayTrip: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.estimatedRowHeight = 140
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.results?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.oneWayTrip == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "onWayTripCell", for: indexPath) as! OneWayTableViewCell
            
            cell.setCellData(data: self.retrunDataForIndexPath(index: indexPath))
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "roundTripCell", for: indexPath) as! RoundTripTableViewCell
            
            cell.setCellData(data: self.retrunDataForIndexPath(index: indexPath))
            
            return cell
        }

    }
    
    
    func retrunDataForIndexPath(index:IndexPath) -> (Result) {
         let cellData = self.results?[index.row]
        return cellData!
    }
}

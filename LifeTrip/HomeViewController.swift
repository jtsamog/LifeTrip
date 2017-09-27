//
//  ViewController.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.rowHeight = self.menuTableView.frame.height / 6;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchFlight () {
        self.performSegue(withIdentifier: "searchFlightSegue", sender: self)
    }
    
    // MARK: TABLE 
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MenuTableViewCell=MenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mycell")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        cell.loadCellWithTag(tag: indexPath.row)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.searchFlight()
        }
    }
}


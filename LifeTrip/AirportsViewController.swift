//
//  AirportsViewController.swift
//  LifeTrip
//
//  Created by Anas Najjar on 9/14/17.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

protocol AirportProtocol {
    func userHasSelectedDestAirport(selectedAirport:AirportData)
    func userHasSelectedOriginAirport(selectedAirport:AirportData)
}

class AirportsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    var airportResults : Array<AirportData?> = []
    var currentQuery : String = ""
    var delegate: AirportProtocol?
    var searchForOrigin: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.airportResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "searchResultCell")
        
        
        let airport = self.airportResults[indexPath.row]
        cell.textLabel?.text = airport?.airportCode
        cell.detailTextLabel?.text = airport?.airportName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let airport = self.airportResults[indexPath.row] {
            if self.searchForOrigin == true {
                self.delegate?.userHasSelectedOriginAirport(selectedAirport: airport)
            } else {
                self.delegate?.userHasSelectedDestAirport(selectedAirport: airport)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            self.airportResults.removeAll()
            self.tableView.reloadData()
        } else {
            self.currentQuery = searchText
            
            ApiManager.sharedInstance.searchForAirport(query: searchText, success: { [weak self](response) in
                
                if response.results.count == 0 {
                    self?.airportResults.removeAll()
                } else {
                    if searchText == self?.currentQuery {
                        self?.airportResults.removeAll()
                        for result in response.results {
                            self?.airportResults.append(result)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }, fail: { (errorMsg) -> (Void) in
                    print(errorMsg)
            })
            
        }
    }
    
    
    
}

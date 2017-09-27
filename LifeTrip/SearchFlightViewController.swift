//
//  SearchFlightViewController.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit
import Eureka
import SwiftSpinner


class SearchFlightViewController: FormViewController, AirportProtocol  {

    var results : Array<Result>? = []
    var searchForOrigin: Bool = false
    var oneWayTrip = false
    var validationMsgShown = false
    var searchAirport  : AirportsViewController? = nil
    var searchObject: SearchFlightRequest = SearchFlightRequest(orgin: "", destination: "", departureDate: "", returnDate: "", adults: 0, children: 0, infants: 0, travelClass: TravelClass.Economy)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.plain, target: self, action: #selector(searchFlight))
        // Eurka Form
        form = Section()
            <<< SegmentedRow<String>("segments"){
                $0.options = ["Round Trip","One Way"]
                $0.value = "Round Trip"
            }.onChange({ (segmentedRow) in
                let dRow: DateRow? = self.form.rowBy(tag: "returnDate")
                if segmentedRow.value == "Round Trip" {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.oneWayTrip = false
                    
                    if let v = dRow?.value {
                        self.searchObject.departureDate = formatter.string(from: v )
                    }
                } else {
                    self.searchObject.returnDate = nil
                    self.oneWayTrip = true

                }
                dRow?.updateCell()

            })
            
            +++ Section("Trip Details")
            <<< LabelRow () {
                $0.title = "From"
                $0.value = "Select Airport"
                $0.tag = "origin"
                }.onCellSelection({ (labelCell, labelRow) in
                    self.searchForOrigin = true
                    self.performSegue(withIdentifier: "searchAirportSegue", sender: nil)
                })
            <<< LabelRow () {
                $0.title = "To"
                $0.value = "Select Airport"
                $0.tag = "destination"
               
                }.onCellSelection({ (labelCell, labelRow) in
                    self.searchForOrigin = false
                    self.performSegue(withIdentifier: "searchAirportSegue", sender: nil)
                })
        
            +++ Section("Date")

            <<< DateRow() { $0.title = "🛫 Departure" ; $0.noValueDisplayText = "Select Date";$0.tag = "departureDate"}.onCellSelection({ (dateCell, dateRow) in
                if dateRow.value == nil {
                dateRow.value = Date()
                dateRow.updateCell()
                }
            }).onChange({ (dateRow) in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.searchObject.departureDate = formatter.string(from: dateRow.baseValue as! Date)
                self.removeValidtionMsg()
            })
            <<< DateRow() { $0.title = "🛬 Return" ; $0.noValueDisplayText = "Select Date";$0.tag = "returnDate";$0.hidden = "$segments != 'Round Trip'" }.onCellSelection({ (dateCell, dateRow) in
                if dateRow.value == nil {
                    dateRow.value = Date()
                    dateRow.updateCell()
                }
            }).onChange({ (dateRow) in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.searchObject.returnDate = formatter.string(from: dateRow.baseValue as! Date)
                self.removeValidtionMsg()
            })
        
            +++ Section("Passengers")
            <<< StepperRow() {
                $0.title = "Adults (+12)"
                $0.value = 0
            }.onChange({ (stepperRow) in
                self.searchObject.adults = Int(stepperRow.value!)
                self.removeValidtionMsg()
            })
            <<< StepperRow() {
                $0.title = "Children (2-11)"
                $0.value = 0
                }.onChange({ (stepperRow) in
                    self.searchObject.children = Int(stepperRow.value!)
                    self.removeValidtionMsg()
                })
            <<< StepperRow() {
                $0.title = "Infants (<2)"
                $0.value = 0
                }.onChange({ (stepperRow) in
                    self.searchObject.infants = Int(stepperRow.value!)
                    self.removeValidtionMsg()
                })
        
            +++ Section("Class")
            <<< SegmentedRow<String>("Class"){
                $0.options = ["Economy", "Business", "First"]
                $0.value = "Economy"
        }.onChange({ (segmentedRow) in
            self.searchObject.travelClass = segmentedRow.value
        })
        
            +++ Section(){$0.tag = "action"}
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Search Flight"
        }.onCellSelection({ [weak self] (cell, row) in
           self?.searchFlight()
          
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Search Flight"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    // MARK: Airport Delegate
    
    func userHasSelectedDestAirport(selectedAirport:AirportData) {
        
        let dRow: LabelRow? = self.form.rowBy(tag: "destination")
        dRow?.value = selectedAirport.airportName
        self.searchObject.destination = selectedAirport.airportCode
        self.removeValidtionMsg()
    }
    
    func userHasSelectedOriginAirport(selectedAirport: AirportData) {
        let dRow: LabelRow? = self.form.rowBy(tag: "origin")
        dRow?.value = selectedAirport.airportName
        self.searchObject.origin = selectedAirport.airportCode
        self.removeValidtionMsg()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "flightsSegue"{
            let vc = segue.destination as! FlightsResultsTableViewController
            vc.results = self.results
            vc.oneWayTrip = self.oneWayTrip
        }
       
        else if segue.identifier == "searchAirportSegue"{
            let vc = segue.destination as! AirportsViewController
            vc.delegate = self
            vc.searchForOrigin = self.searchForOrigin
        }
    }
    
    func validateSearch () -> (String) {
        
        var msg : String = ""
        if (self.searchObject.origin?.isEmpty)! {
            msg = "Please choose origin airport"
        }
        else if (self.searchObject.destination?.isEmpty)! {
            msg = "Please choose destination airport"
        }
        else if (self.searchObject.departureDate?.isEmpty)! {
            msg = "Please select departure date"
        }
        else  if (self.searchObject.adults == 0) && (self.searchObject.infants == 0) && (self.searchObject.children == 0) {
            msg = "Please add a passenger"
        }
        else if (self.oneWayTrip == false) {
            if let rd = self.searchObject.returnDate {
                if rd.isEmpty {
                    msg = "Please select return date"
                }
            }
        }
        return msg
    }
    
    @objc
    func searchFlight () {
        let msg = self.validateSearch()
        if (msg.characters.count) > 0  {
            var section: Section?  = self.form.sectionBy(tag: "action")
            let labelRow = LabelRow() {
                $0.title = msg
                $0.tag = "validitionMsg"
                $0.baseCell.textLabel?.textColor = .white
                $0.cell.height = { 30 }
                $0.baseCell.backgroundColor = .red
                self.validationMsgShown = true
            }
            section?.insert(labelRow, at: 0)
            
        } else {
            self.removeValidtionMsg()
            self.apiCall()
        }
        
    }
    func removeValidtionMsg () {
        if (self.validationMsgShown == true) {
            if let section = self.form.sectionBy(tag: "action") {
                section.remove(at: 0)
                self.validationMsgShown = false
            }
        }
    }
    
    func apiCall () {
        if let o = self.searchObject.origin, let d = self.searchObject.destination {
            let text = "\(o) → \(d)\n\nLet's find you a flight!"
            SwiftSpinner.show(text)
            ApiManager.sharedInstance.searchForFlight( searchDetails: self.searchObject, success: { (response) in
                
                SwiftSpinner.hide({
                    self.results = response.results
                    self.performSegue(withIdentifier: "flightsSegue", sender: nil)
                })
                
            }) { (errorString) -> (Void) in
                SwiftSpinner.hide({
                    let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Try Again !", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                })
                
                print(errorString)
            }
        }
    }
    
    
    
}

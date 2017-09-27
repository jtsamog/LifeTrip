//
//  RoundTripTableViewCell.swift
//  LifeTrip
//
//  Created by Anas Najjar on 13/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class RoundTripTableViewCell: UITableViewCell {


    
    //Airports
    @IBOutlet weak var outDepAirportLabel: UILabel!
    @IBOutlet weak var outArrivalAirportLabel: UILabel!
    @IBOutlet weak var inDepAirportLabel: UILabel!
    @IBOutlet weak var inArrivalAirportLabel: UILabel!
    
    //time
    @IBOutlet weak var outDepTimeLabel: UILabel!
    @IBOutlet weak var outArrivalTimeLabel: UILabel!
    @IBOutlet weak var inDepTimeLabel: UILabel!
    @IBOutlet weak var inArrivalTimeLabel: UILabel!
    
    //date
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    
    //airline
    @IBOutlet weak var airlineLabel: UILabel!
    
    //price
    @IBOutlet weak var totalPriceLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellData (data:Result) {
        
        let trip = data.itineraries[0]
        let outbound = trip.outbound?.flights[0]
        
        
        self.outDepAirportLabel.text = outbound?.origin?.airport
        self.outArrivalAirportLabel.text = outbound?.destination?.airport
        self.airlineLabel.text =  AirlinesManager.sharedInstance.getAirlinesNameForCode( code: (outbound?.operatingAirline)!)
        
        let inbound = trip.inbound?.flights[0]
        self.inDepAirportLabel.text = inbound?.origin?.airport
        self.inArrivalAirportLabel.text = inbound?.destination?.airport
        
        if let price = data.fare?.totalPrice {
            self.totalPriceLabel.text = "$\(price)"
        }
        
        //date and time
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm" //Your date format
        
        let outDepatureDate =  dateFormatter.date(from:(outbound?.departsAt)!)!
        let outArrivalDate =  dateFormatter.date(from:(outbound?.departsAt)!)!
        
        let inDepatureDate =  dateFormatter.date(from:(inbound?.departsAt)!)!
        let inArrivalDate =  dateFormatter.date(from:(inbound?.departsAt)!)!
        
       
        dateFormatter.dateFormat = "MM-dd-yyyy"

        self.departureDateLabel.text = dateFormatter.string(from: outDepatureDate)
        self.returnDateLabel.text = dateFormatter.string(from: inDepatureDate)
        
        dateFormatter.dateFormat = "h:mm a"
        self.outDepTimeLabel.text = dateFormatter.string(from: outDepatureDate)
        self.outArrivalTimeLabel.text = dateFormatter.string(from: outArrivalDate)
        
        self.inDepTimeLabel.text = dateFormatter.string(from: inDepatureDate)
        self.inArrivalTimeLabel.text = dateFormatter.string(from: inArrivalDate)
        
    }
}

//
//  OneWayTableViewCell.swift
//  LifeTrip
//
//  Created by Anas Najjar on 9/18/17.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class OneWayTableViewCell: UITableViewCell {

    //Airports
    @IBOutlet weak var outDepAirportLabel: UILabel!
    @IBOutlet weak var outArrivalAirportLabel: UILabel!
    
    
    //time
    @IBOutlet weak var outDepTimeLabel: UILabel!
    @IBOutlet weak var outArrivalTimeLabel: UILabel!
    
    
    //date
    @IBOutlet weak var departureDateLabel: UILabel!
    
    
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
        
        
        if let price = data.fare?.totalPrice {
            self.totalPriceLabel.text = "$\(price)"
        }
        
        //date and time
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm" //Your date format
        
        let outDepatureDate =  dateFormatter.date(from:(outbound?.departsAt)!)!
        let outArrivalDate =  dateFormatter.date(from:(outbound?.departsAt)!)!
        
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        self.departureDateLabel.text = dateFormatter.string(from: outDepatureDate)
        
        dateFormatter.dateFormat = "h:mm a"
        self.outDepTimeLabel.text = dateFormatter.string(from: outDepatureDate)
        self.outArrivalTimeLabel.text = dateFormatter.string(from: outArrivalDate)

        
    }

}

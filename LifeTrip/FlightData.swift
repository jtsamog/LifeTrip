//
//  FlightData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class FlightData {
    public var departsAt : String?
    public var arrivesAt : String?
    public var origin : Origin?
    public var destination : Destination?
    public var marketingAirline : String?
    public var operatingAirline : String?
    public var flightNumber : Int?
    public var aircraft : Int?
    public var bookingInfo : BookingInfo?
    
    required public init(dictionary: [String:Any?]) {
        
        departsAt = dictionary["departs_at"] as? String
        arrivesAt = dictionary["arrives_at"] as? String
        
        if let _origin = dictionary["origin"] as? [String:Any?] {
            origin = Origin(dictionary: _origin)
        }
        
        if let _destination = dictionary["destination"] as? [String:Any?] {
            destination = Destination(dictionary: _destination)
        }
        
        marketingAirline = dictionary["marketing_airline"] as? String
        operatingAirline = dictionary["operating_airline"] as? String
        flightNumber = dictionary["flight_number"] as? Int
        aircraft = dictionary["aircraft"] as? Int
        
        if let booking = dictionary["booking_info"] as? [String:Any?] {
            bookingInfo = BookingInfo(dictionary: booking)
        }
    }
    
    func description() -> String{
        
        let mirrored_object = Mirror(reflecting: self)
        let str:NSMutableString = NSMutableString()
        for (index, attr) in mirrored_object.children.enumerated() {
            if let property_name = attr.label as String! {
                str.append(" Attr \(index): \(property_name) = \(attr.value)")
            }
        }
        //print("desc=\(str)")
        return str as String
    }
}

//
//  BookingInfo.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class BookingInfo {
    public var travelClass : String?
    public var bookingCode : String?
    public var seatsRemaining : Int?
    
    required public init(dictionary: [String:Any?]) {
        travelClass = dictionary["travel_class"] as? String
        bookingCode = dictionary["booking_code"] as? String
        seatsRemaining = dictionary["seats_remaining"] as? Int
    }

}

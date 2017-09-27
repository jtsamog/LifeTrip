//
//  Itinerary.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class Itinerary {
    public var outbound : TripData?
    public var inbound : TripData?
    
    required public init(dictionary: [String:Any?]) {
        if let _outbound = dictionary["outbound"] as? [String:Any?] {
            outbound = TripData(dictionary: _outbound)
        }
        if let _inbound = dictionary["inbound"] as? [String:Any?] {
            inbound = TripData(dictionary: _inbound)
        }

    }
    
}

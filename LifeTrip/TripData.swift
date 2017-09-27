//
//  TripData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class TripData {
    public var flights : Array<FlightData>
    
    required public init(dictionary: [String:Any?]) {
        flights = (dictionary["flights"] as? Array<[String:Any?]>)?.map { FlightData(dictionary: $0) } ?? []
    }
}

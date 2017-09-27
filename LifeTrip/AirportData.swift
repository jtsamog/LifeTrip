//
//  AirportData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 01/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class AirportData {
    public var airportCode : String?
    public var airportName : String?
    
    required public init(dictionary: [String:Any?]) {
        airportCode = dictionary["value"] as? String
        airportName = dictionary["label"] as? String
    }
}

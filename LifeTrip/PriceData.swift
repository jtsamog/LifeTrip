//
//  PriceData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import Foundation

class PriceData {
    public var tax : String?
    public var totalFare : String?
    
    required public init(dictionary: [String:Any?]) {
        
        tax = dictionary["tax"] as? String
        totalFare = dictionary["total_fare"] as? String
    }
}

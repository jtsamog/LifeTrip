//
//  FareData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import Foundation

class FareData {
    public var pricePerAdult : PriceData?
    public var restrictions : RestrictionsData?
    public var totalPrice : String?
    
    
    required public init(dictionary:  [String:Any?]) {
        
        if let _pricePerAdult = dictionary["price_per_adult"] as? [String:Any?] {
            pricePerAdult = PriceData(dictionary: _pricePerAdult)
        }
        
        if let _restrictions = dictionary["restrictions"] as? [String:Any?] {
            restrictions = RestrictionsData(dictionary: _restrictions)
        }
        
        totalPrice = dictionary["total_price"] as? String
    }
}

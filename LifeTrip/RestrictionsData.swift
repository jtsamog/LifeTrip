//
//  RestrictionsData.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import Foundation

class RestrictionsData {
    public var change_penalties : Bool?
    public var refundable : Bool?
    
    required public init(dictionary: [String:Any?]) {
        
        change_penalties = dictionary["change_penalties"] as? Bool
        refundable = dictionary["refundable"] as? Bool
    }
    
}


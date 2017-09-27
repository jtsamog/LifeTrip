//
//  Result.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class Result {
    public var fare : FareData?
    public var itineraries : Array<Itinerary>
    
    
    required public init(dictionary: [String:Any?]) {
        
        itineraries = (dictionary["itineraries"] as? Array<[String:Any?]>)?.map { Itinerary(dictionary: $0)} ?? []

        if let _fare = dictionary["fare"] as? [String:Any?] {
            fare = FareData(dictionary: _fare)
        }
    }

    
}

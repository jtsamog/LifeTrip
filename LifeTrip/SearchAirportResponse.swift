//
//  SearchAirportResponse.swift
//  LifeTrip
//
//  Created by Anas Najjar on 01/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class SearchAirportResponse {
    
    public var results : Array<AirportData>
    
    required public init(array: Array<[String:Any?]>) {
        results = array.map { AirportData(dictionary: $0) } 
    }
}

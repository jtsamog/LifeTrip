//
//  SearchFlightResponse.swift
//  LifeTrip
//
//  Created by Anas Najjar on 29/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

class SearchFlightResponse {
    public var currency : String?
    public var results : Array<Result>
    
    
    required public init(dictionary: [String:Any?]) {
        currency = dictionary["currency"] as? String
        results = (dictionary["results"] as? Array<[String:Any?]>)?.map {
            Result(dictionary: $0)
        } ?? []
        
    }
}

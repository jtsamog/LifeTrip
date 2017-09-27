//
//  SearchFlightRequest.swift
//  LifeTrip
//
//  Created by Anas Najjar on 07/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

enum TravelClass: String {
    case Economy, Business, First
}

class SearchFlightRequest {
    public var origin : String?
    public var destination : String?
    public var departureDate : String?
    public var returnDate : String?
    public var adults : Int?
    public var children : Int?
    public var infants : Int?
    public var travelClass : String?
    
    
     public init(orgin: String, destination: String, departureDate: String, returnDate: String, adults: Int , children: Int, infants: Int, travelClass: TravelClass) {
        self.origin = orgin
        self.destination = destination
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.adults = adults
        self.children = children
        self.infants = infants
        self.travelClass = travelClass.rawValue
    }
}

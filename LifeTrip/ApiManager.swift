//
//  ApiManager.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit
let API_KEY = "PUT_API_KEY_HERE"
let API_Flight = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=\(API_KEY)&"
let API_Airport = "http://api.sandbox.amadeus.com/v1.2/airports/autocomplete?apikey=\(API_KEY)&term="

private let sharedManager = ApiManager ()

class ApiManager: NSObject {
    
    class var sharedInstance: ApiManager {
        return sharedManager
    }
    
    // MARK: Search for a flight
    
    func searchForFlight(searchDetails:SearchFlightRequest!, success:@escaping (SearchFlightResponse) -> Void,fail:@escaping (String) -> (Void))  {
        
        if let origin = searchDetails.origin, let des = searchDetails.destination, let depDate = searchDetails.departureDate, let adult = searchDetails.adults, let flightClass = searchDetails.travelClass {
            
            var parameters : String! = "origin=\(origin)&destination=\(des)&departure_date=\(depDate)&adults=\(adult)&travel_class=\(flightClass)&number_of_results=5&direct=true"
            
            if let returnDate = searchDetails.returnDate {
                parameters = parameters + "&return_date=\(returnDate)"
            }
            
            let urlString = API_Flight + parameters
            
            let dataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
                if ((data) != nil)
                {
                    let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String:Any]
                    
                    if (json?["results"]) == nil  {
                        fail((json?["message"] as? String) ?? "Unknown server error")
                    }
                    else
                    {
                        let fareData = SearchFlightResponse(dictionary: json!)
                        success(fareData)
                    }
                }
                else
                {
                    fail("error")
                }
            }
            dataTask.resume()
        }
    }
    
    // MARK: autocomplete search for airport
    
    func searchForAirport(query:String?,success:@escaping (SearchAirportResponse) -> Void,fail:@escaping (String) -> (Void))  {
        
        let urlString = URL(string: API_Airport+query!)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, urlRequestResponse, error) in
                let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Array<[String:Any?]>
                
                if  error != nil {
                    fail(error as! String)
                } else {
                    let result = SearchAirportResponse(array: json!)
                    success(result)
                }
            })
            task.resume()
        }
    }
    
}

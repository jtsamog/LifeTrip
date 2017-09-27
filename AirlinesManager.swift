//
//  AirlinesManager.swift
//  LifeTrip
//
//  Created by Anas Najjar on 13/09/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import UIKit

private let sharedManager = AirlinesManager ()

class AirlinesManager: NSObject {
    
    class var sharedInstance: AirlinesManager {
        return sharedManager
    }
    
    
    func getAirlinesNameForCode (code:String) -> String {
        
        var airlineName : String = ""
        
        if let fileUrl = Bundle.main.url(forResource: "airlines", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: String]] { // [String: Any] which ever it is
                
                let airlinesDic = result?[0]
                
                airlineName = airlinesDic?.first { (key,value) -> Bool in
                    key == code
                }?.value ?? "Unknown airline"
                
            }
        }
        return airlineName
    }
}

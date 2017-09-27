//
//  Destination.swift
//  LifeTrip
//
//  Created by Anas Najjar on 27/08/2017.
//  Copyright © 2017 Anas Najjar. All rights reserved.
//

import Foundation
 
public class Destination {
	public var airport : String?
	public var terminal : Int?

	required public init(dictionary: [String:Any?]) {

		airport = dictionary["airport"] as? String
		terminal = dictionary["terminal"] as? Int
	}

}

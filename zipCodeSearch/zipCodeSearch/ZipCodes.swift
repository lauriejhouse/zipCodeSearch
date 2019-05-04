//
//  ZipCodes.swift
//  zipCodeSearch
//
//  Created by Jackie Norstrom on 5/4/19.
//  Copyright © 2019 Oblast. All rights reserved.
//

import Foundation


class zipCode {
    
    private var _city: String!
    private var _zipCode: Int!
    
    
    var city: String {
        return _city
    }
    
    var zipCode: Int {
        return _zipCode
    }
    
    
    
    init(name: String, number: Int) {
        
        self._city = name
        self._zipCode = number
    }
    
}

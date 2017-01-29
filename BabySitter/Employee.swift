//
//  Employee.swift
//  BabySitter
//
//  Created by Mina Shehata Gad on 1/29/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import Foundation

class Employee {
    
    
    
    var TransferID:String?
    var FromAddress:String?
    var ToAddress:String?
    var ToLat:String?
    var FromLat:String?
    var ToLong:String?
    var FromLong:String?
    
    init(TransferID:String,FromAddress:String,ToAddress:String,ToLat:String,FromLat:String,ToLong:String,FromLong:String) {
        
        self.TransferID = TransferID
        self.FromAddress = FromAddress
        self.ToAddress = ToAddress
        self.ToLat = ToLat
        self.FromLat = FromLat
        self.ToLong = ToLong
        self.FromLong = FromLong
        
    }
    
    
    
    
    
    
}

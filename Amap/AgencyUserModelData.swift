//
//  AgencyUserModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class AgencyUserModelData {
  
  var id: String! = nil
  var firstName: String! = nil
  var lastName: String! = nil
  var email: String! = nil
  
  init(newId: String, newFirstName: String, newLastName: String) {
    
    id = newId
    firstName = newFirstName
    lastName = newLastName
    
  }
  
  
}
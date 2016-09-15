//
//  BrandModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class BrandModelData {
  
  var id: String! = nil
  var name: String! = nil
  var contactName: String?
  var contactEMail: String?
  var contactPosition: String?
  var proprietaryCompany: String?
  
  init(newId: String!, newName: String!, newContactName: String?, newContactEMail: String?, newContactPosition: String?, newProprietaryCompany: String?) {
    
    id = newId
    name = newName
    contactName = newContactName
    contactEMail = newContactEMail
    contactPosition = newContactPosition
    proprietaryCompany = newProprietaryCompany
    
  }
  
}
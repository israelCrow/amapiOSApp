//
//  MyCompanyModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class MyCompanyModelData: NSObject {
  
  static var Data = MyCompanyModelData()
  
  var id: String! = nil
  var name: String! = nil
  var contactName: String! = nil
  var contactEMail: String! = nil
  var contactPosition: String! = nil
  var logoURL: String! = nil
  
  var brands = [BrandModelData]()
  
  init(newId: String!, newName: String!, newBrands:[BrandModelData]) {
    
    id = newId
    name = newName
    if newBrands.count > 0 {
      
      brands = newBrands
      
    }
    
  }
  
  private override init(){}
  
  
}
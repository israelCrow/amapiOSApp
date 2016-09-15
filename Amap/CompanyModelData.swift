//
//  CompanyModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class CompanyModelData {
  
  var id: String! = nil
  var name: String! = nil
  var brands = [BrandModelData]()
  
  init(newId: String!, newName: String!, newBrands:[BrandModelData]) {
    
    id = newId
    name = newName
    if newBrands.count > 0 {
      
      brands = newBrands
      
    }
    
  }
  
}

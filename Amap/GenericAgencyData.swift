//
//  GenericAgencyData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class GenericAgencyData {
  
  var id: String! = nil
  var name: String! = nil
  var isFavorite: Bool! = nil
  
  init(newId: String, newName: String, newIsFavorite: Bool) {
    
    id = newId
    name = newName
    isFavorite = newIsFavorite
    
  }
  
}
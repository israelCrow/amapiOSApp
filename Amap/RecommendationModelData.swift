//
//  RecommendationModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class RecommendationModelData {
  
  var body: String! = nil
  var recoId: String! = nil
  var iconName: String! = nil
  
  init(newBody: String, newRecoId: String) {
    
    body = newBody
    recoId = newRecoId
    
  }
  
}


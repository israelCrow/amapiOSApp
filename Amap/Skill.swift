//
//  Skill.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/29/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

struct Skill {
  
  var id: String! = nil
  var name: String! = nil
  var level: Int?
  
  init(id: String, nameSkill: String, levelSkill: Int?) {
    
    self.id = id
    self.name = nameSkill
    self.level = levelSkill
    
  }
  
}
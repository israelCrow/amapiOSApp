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
  var skillCategoryId: String?
  
  init(id: String, nameSkill: String, levelSkill: Int?) {
    
    self.id = id
    self.name = nameSkill
    self.level = levelSkill
    
  }
  
  init(id: String, nameSkill: String, levelSkill: Int?, skill_category_id: String?) {
    
    self.id = id
    self.name = nameSkill
    self.level = levelSkill
    self.skillCategoryId = skill_category_id
    
  }
  
}
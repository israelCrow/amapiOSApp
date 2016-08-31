//
//  SkillCategory.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/29/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

struct SkillCategory {
  
  var id: String! = nil
  var name: String! = nil
  var collapsed: Bool!
  var arrayOfSkills: [Skill]! = nil
  
  init(id: String, name: String, arrayOfSkills: [Skill], isCollapsed: Bool) {
    
    self.id = id
    self.name = name
    self.collapsed = isCollapsed
    self.arrayOfSkills = arrayOfSkills
    
  }
  
}
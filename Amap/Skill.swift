//
//  Skill.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation


struct Skill {
  
  var nameOfSkill: String! = nil
  var scoreOfSkill: Int! = nil
  
  init(nameSkill: String, scoreSkill: Int) {
    
    self.nameOfSkill = nameSkill
    self.scoreOfSkill = scoreSkill
    
  }
  
}
//
//  PitchSkillCategory.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

struct PitchSkillCategory {
  
  var pitchSkillCategoryId: String! = nil
  var pitchSkillCategoryName: String! = nil
  var isThisCategory: Bool = false
  var skills: [Skill]! = nil
  
  var positionInOriginalArray: Int?
  
  init(newPitchSkillCategoryId: String!, newSkillCategoryName: String!, newIsThisCategory: Bool!, newSkills: [Skill]!) {
    
    pitchSkillCategoryId = newPitchSkillCategoryId
    pitchSkillCategoryName = newSkillCategoryName
    isThisCategory = newIsThisCategory
    skills = newSkills
    
  }
  
}
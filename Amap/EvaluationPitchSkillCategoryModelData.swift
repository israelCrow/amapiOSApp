//
//  EvaluationPitchSkillCategoryModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

struct EvaluationPitchSkillCategoryModelData {
  
  var evaluationSkillCategoryId: String! = nil
  var evaluationSkillCategoryName: String! = nil
  
  init(newEvaluationSkillCategoryId: String!, newEvaluationSkillCategoryName: String!) {
    
    evaluationSkillCategoryId = newEvaluationSkillCategoryId
    evaluationSkillCategoryName = newEvaluationSkillCategoryName
  }
  
}
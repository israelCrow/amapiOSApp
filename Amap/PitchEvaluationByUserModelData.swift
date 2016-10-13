//
//  PitchEvaluationByUserModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/29/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchEvaluationByUserModelData {
  
  var pitchEvaluationId: String! = nil
  var pitchId: String! = nil
  var pitchName: String! = nil
  var briefDate: String! = nil
  var score: Int! = nil
  var brandName: String! = nil
  var companyName: String! = nil
  var otherScores: [Int]! = nil
  var arrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData]! = nil
  
  init( newPitchEvaluationId: String, newPitchId: String, newPitchName: String, newBriefDate: String, newScore: Int, newBrandName: String, newCompanyName: String, newOtherScores: [Int], newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData]) {
    
    pitchEvaluationId = newPitchEvaluationId
    pitchId = newPitchId
    pitchName = newPitchName
    briefDate = newBriefDate
    score = newScore
    brandName = newBrandName
    companyName = newCompanyName
    otherScores = newOtherScores
    arrayOfEvaluationPitchSkillCategory = newArrayOfEvaluationPitchSkillCategory
    
  }
  
}
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
  var wasWon: Bool?
  var pitchStatus: Int! = nil
  var evaluationStatus: Bool! = nil //to know if has a pitch evaluation
  var hasResults: Bool! = nil       //to know if the questionnaire "add results" has been done
  var hasPitchWinnerSurvey: Bool! = nil //to know if the questionnaire "winner survey" has been done
  var pitchResultsId: String! = nil
  
  init( newPitchEvaluationId: String, newPitchId: String, newPitchName: String, newBriefDate: String, newScore: Int, newBrandName: String, newCompanyName: String, newOtherScores: [Int], newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData], newWasWon: Bool?, newPitchStatus: Int, newEvaluationStatus: Bool, newHasResults: Bool, newHasPitchWinnerSurvey: Bool, newPitchResultsId: String) {
    
    pitchEvaluationId = newPitchEvaluationId
    pitchId = newPitchId
    pitchName = newPitchName
    briefDate = newBriefDate
    score = newScore
    brandName = newBrandName
    companyName = newCompanyName
    otherScores = newOtherScores
    arrayOfEvaluationPitchSkillCategory = newArrayOfEvaluationPitchSkillCategory
    wasWon = newWasWon
    pitchStatus = newPitchStatus
    evaluationStatus = newEvaluationStatus
    hasResults = newHasResults
    hasPitchWinnerSurvey = newHasPitchWinnerSurvey
    pitchResultsId = newPitchResultsId
    
  }
  
}
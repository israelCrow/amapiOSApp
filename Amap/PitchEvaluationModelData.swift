//
//  PitchEvaluationModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/27/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchEvaluationModelData {
  
  var id: String! = nil
  var pitchId: String! = nil
  var userId: String! = nil
  var evaluationStatus: Bool! = nil
  var pitchStatus: String! = nil
  var areObjectivesClear: Bool! = nil
  var timeToPresent: String! = nil
  var isBudgetKnown: Bool! = nil
  var numberOfAgencies: String! = nil
  var areDeliverablesClear: Bool! = nil
  var isMarketingInvolved: String! = nil
  var timeToKnowDecision: String! = nil
  var score: String! = nil
  var activityStatus: String! = nil
  var wasWon: Bool! = nil
  var numberOfRounds: String! = nil
  var deliverCopyrightForPitching: String! = nil
  var hasSelectionCriteria: Bool! = nil
  
  init(
    newId: String,
    newPitchId: String,
    newUserId: String,
    newEvaluationStatus: Bool,
    newPitchStatus: String,
    newAreObjectivesClear: Bool,
    newTimeToPresent: String,
    newIsBudgetKnown: Bool,
    newNumberOfAgencies: String,
    newAreDeliverablesClear: Bool,
    newIsMarketingInvolved: String,
    newTimeToKnowDecision: String,
    newScore: String,
    newActivityStatus: String,
    newWasWon: Bool,
    newNumberOfRounds: String,
    newDeliverCopyrightForPitching: String,
    newHasSelectionCriteria: Bool)
    {
    
      id = newId
      pitchId = newPitchId
      userId = newUserId
      evaluationStatus = newEvaluationStatus
      pitchStatus = newPitchStatus
      areObjectivesClear = newAreObjectivesClear
      timeToPresent = newTimeToPresent
      isBudgetKnown = newIsBudgetKnown
      numberOfAgencies = newNumberOfAgencies
      areDeliverablesClear = newAreDeliverablesClear
      isMarketingInvolved = newIsMarketingInvolved
      timeToKnowDecision = newTimeToKnowDecision
      score = newScore
      activityStatus = newActivityStatus
      wasWon = newWasWon
      numberOfRounds = newNumberOfRounds
      deliverCopyrightForPitching = newDeliverCopyrightForPitching
      hasSelectionCriteria = newHasSelectionCriteria
    
    }
  
}
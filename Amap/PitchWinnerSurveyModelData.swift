//
//  PitchWinnerSurveyModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 08/03/17.
//  Copyright © 2017 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchWinnerSurveyModelData {
  
  var pitchWinnerSurveyId: String?
  var agencyId: String?
  var alreadySignForTheProject: Bool?
  var dateOfSignForTheProject: String?
  var alreadyActiveTheProject: Bool?
  var dateOfActiveTheProject: String?
  
  init(newPitchResultsId: String?, newAgencyId: String?, newAlreadySign: Bool?, newDateOfSign: String?, newAlreadyActive: Bool?, newDateOfActivation: String?) {
    
    pitchWinnerSurveyId = newPitchResultsId
    agencyId = newAgencyId
    alreadySignForTheProject = newAlreadySign
    dateOfSignForTheProject = newDateOfSign
    alreadyActiveTheProject = newAlreadyActive
    dateOfActiveTheProject = newDateOfActivation

  }
  
}
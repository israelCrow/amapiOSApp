//
//  PitchResultsModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchResultsModelData {
  
  var pitchResultsId: String?
  var agencyId: String?
  var gotFeedback: Bool?
  var gotResponse: Bool?
  var hasSomeoneElseWon: Bool?
  var pitchId: String?
  var wasPitchWon: Bool?
  var wasProposalPresented: Bool?
  var whenAreYouPresenting: String?
  var whenWillYouGetResponse: String?
  
  init(newPitchResultsId: String?, newAgencyId: String?, newGotFeedback: Bool?, newGotResponse: Bool?, newHasSomeoneElseWon: Bool?, newPitchId: String?, newWasPitchWon: Bool?, newWasProposalPresented: Bool?, newWhenAreYouPresenting: String?, newWhenWillYouGetResponse: String?) {
    
    pitchResultsId = newPitchResultsId
    agencyId = newAgencyId
    gotFeedback = newGotFeedback
    gotResponse = newGotResponse
    hasSomeoneElseWon = newHasSomeoneElseWon
    pitchId = newPitchId
    wasPitchWon = newWasPitchWon
    wasProposalPresented = newWasProposalPresented
    whenAreYouPresenting = newWhenAreYouPresenting
    whenWillYouGetResponse = newWhenWillYouGetResponse
    
  }
  
}
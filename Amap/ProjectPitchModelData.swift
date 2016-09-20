//
//  ProjectPitchModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class ProjectPitchModelData {
  
  var name: String! = nil
  var brandId: String! = nil
  var briefDate: String! = nil
  var briefEMailContact: String! = nil
  var arrayOfPitchCategories: Array<PitchSkillCategory>! = nil
  
  init(newName: String!, newBrandId: String!, newBriefDate: String!, newBrieEMailContact: String!, newArrayOfPitchCategories: Array<PitchSkillCategory>!) {
    
    name = newName
    brandId = newBrandId
    briefDate = newBriefDate
    briefEMailContact = newBrieEMailContact
    arrayOfPitchCategories = newArrayOfPitchCategories
    
  }

}
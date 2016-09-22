//
//  ProjectPitchModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class ProjectPitchModelData {
  
  var id: String! = nil
  var name: String! = nil
  var brandId: String! = nil
  var briefDate: String! = nil
  var briefEMailContact: String! = nil
  var arrayOfPitchCategories: Array<PitchSkillCategory>! = nil
  
  var brandData: BrandModelData?
  var companyData: CompanyModelData?
  
  init(newName: String!, newBrandId: String!, newBriefDate: String!, newBrieEMailContact: String!, newArrayOfPitchCategories: Array<PitchSkillCategory>!) {
    
    name = newName
    brandId = newBrandId
    briefDate = newBriefDate
    briefEMailContact = newBrieEMailContact
    arrayOfPitchCategories = newArrayOfPitchCategories
    
  }
  
  init(newId: String!, newName: String!, newBrandId: String!, newBriefDate: String!, newBrieEMailContact: String!, newArrayOfPitchCategories: Array<PitchSkillCategory>!) {
    
    id = newId
    name = newName
    brandId = newBrandId
    briefDate = newBriefDate
    briefEMailContact = newBrieEMailContact
    arrayOfPitchCategories = newArrayOfPitchCategories
    
  }

}
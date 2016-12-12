//
//  AgencyModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/26/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class AgencyModel: NSObject {
  
  static var Data = AgencyModel()
  
  var id: String! = nil
  var name: String! = nil
  var phone: String! = nil
  var contact_name: String?
  var contact_email: String?
  var address: String?
  var latitude: String?
  var longitude: String?
  var website_url: String?
  var num_employees: String?
  var golden_pitch: Bool?
  var silver_pitch: Bool?
  var high_risk_pitch: Bool?
  var medium_risk_pitch: Bool?
  var logo: String?
  var success_cases: [Case]?
  var skillsLevel: [Skill]?
  var criteria: [CriteriaModelData]?
  var exclusivityBrands: [ExclusivityBrandModelData]?
  
  func reset() {
    
    id = nil
    name = nil
    phone = nil
    contact_name = nil
    contact_email = nil
    address = nil
    latitude = nil
    longitude = nil
    website_url = nil
    num_employees = nil
    golden_pitch = nil
    silver_pitch = nil
    high_risk_pitch = nil
    medium_risk_pitch = nil
    logo = nil
    success_cases = nil
    skillsLevel = nil
    criteria = nil
    exclusivityBrands = nil
    
  }
  
  private override init(){}
  
  
}
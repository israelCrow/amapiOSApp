//
//  RequestToServerManager.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/26/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation
import Alamofire

class RequestToServerManager: NSObject {

  static let sharedInstance = RequestToServerManager()
  
  func requestForAgencyData(functionToMakeWhenBrinInfo: ()-> Void) {
    let urlToRequest = "http://amap-dev.herokuapp.com/api/agencies/\(AgencyModel.Data.id!)"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          AgencyModel.Data.address = json["address"] as? String
          AgencyModel.Data.contact_email = json["contact_email"] as? String
          AgencyModel.Data.contact_name = json["contact_name"] as? String
          AgencyModel.Data.latitude = json["latitude"] as? String
          AgencyModel.Data.logo = json["logo"] as? String
          AgencyModel.Data.longitude = json["longitude"] as? String
          AgencyModel.Data.name = json["name"] as? String
          AgencyModel.Data.num_employees = json["num_employees"] as? String
          AgencyModel.Data.phone = json["phone"] as? String
          AgencyModel.Data.website_url = json["website_url"] as? String
          
          var golden_pitch_bool: Bool
          var silver_pitch_bool: Bool
          var high_risk_pitch_bool: Bool
          var medium_risk_pitch_bool: Bool
          
          let golden_pitch_string = json["golden_pitch"] as? Int
          if golden_pitch_string != nil && golden_pitch_string! == 1 {
            golden_pitch_bool = true
          }else{
            golden_pitch_bool = false
          }
          
          let silver_pitch_string = json["silver_pitch"] as? Int
          if silver_pitch_string != nil && silver_pitch_string! == 1 {
            silver_pitch_bool = true
          }else{
            silver_pitch_bool = false
          }
          
          let high_risk_pitch_string = json["high_risk_pitch"] as? Int
          if high_risk_pitch_string != nil && high_risk_pitch_string! == 1 {
            high_risk_pitch_bool = true
          }else{
            high_risk_pitch_bool = false
          }
          
          let medium_risk_pitch_string = json["medium_risk_pitch"] as? Int
          if medium_risk_pitch_string != nil && medium_risk_pitch_string! == 1 {
            medium_risk_pitch_bool = true
          }else{
            medium_risk_pitch_bool = false
          }
          
          AgencyModel.Data.golden_pitch = golden_pitch_bool
          AgencyModel.Data.silver_pitch = silver_pitch_bool
          AgencyModel.Data.high_risk_pitch = high_risk_pitch_bool
          AgencyModel.Data.medium_risk_pitch = medium_risk_pitch_bool
          
          let arrayOfSuccessCases = json["success_cases"] as? [AnyObject]
          self.saveAllSuccessfulCases(arrayOfSuccessCases)
          
//          print(AgencyModel.Data.address!)
          
          functionToMakeWhenBrinInfo()
          
        }
        
    }
    
  }

  private func saveAllSuccessfulCases(rawCases: [AnyObject]?) {
    
    if rawCases != nil {
      
      let allRawCases = rawCases!
      
      var allCases = [Case]()
      
      for rawCase in allRawCases {
        
        var newCaseId: String! = nil
        var newCaseName: String! = nil
        var newCaseDescription: String! = nil
        var newCaseUrl: String! = nil
        var newCaseImageUrl: String! = nil
        var newCaseAgencyId: String! = nil
        
        print("BOLA!!! \(rawCase)")
        
        if rawCase["id"] as? Int != nil {
          let id_string = String(rawCase["id"] as! Int)
          newCaseId = id_string
        }
        if rawCase["name"] as? String != nil {
          newCaseName = rawCase["name"] as! String
        }
        if rawCase["description"] as? String != nil {
          newCaseDescription = rawCase["description"] as! String
        }
        if rawCase["url"] as? String != nil {
          newCaseUrl = rawCase["url"] as! String
        }
        if rawCase["case_image"] as? String != nil {
          newCaseImageUrl = rawCase["case_image"] as! String
        }
        if rawCase["agency_id"] as? String != nil {
          newCaseAgencyId = rawCase["agency_id"] as! String
        }
        
        let newCase = Case(id: newCaseId,
                           name: newCaseName,
                           description: newCaseDescription,
                           url: newCaseUrl,
                           case_image_url: newCaseImageUrl,
                           case_image: nil,
                           agency_id: newCaseAgencyId)
        
        allCases.append(newCase)
        
      }
      
      AgencyModel.Data.success_cases = allCases
      //      print("CASES IN AGENCY MODEL: \(AgencyModel.Data.success_cases)")
      
    }
    
  }

  func requestForDeleteAgencyCase(caseData: Case, actionToMakeAfterDelete: () -> Void) {
    
//    let urlToRequest = "http://amap-dev.herokuapp.com/api/success_casers/destroy"
//    
//    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
//    requestConnection.HTTPMethod = "POST"
//    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
//    
//    print(caseData)
//    
//    let params = ["id" : caseData.id,
//                  "auth_token" : UserSession.session.auth_token
//                  ]
//    
//    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
//    
//    Alamofire.request(requestConnection)
//      .validate(statusCode: 200..<400)
//      .responseJSON{ response in
//        if response.response?.statusCode == 204 {
//          
//          actionToMakeAfterDelete()
//          
//        }else{
//          print("ERROR DELETING CASE")
//        }
//        
//    }
//    
  }


}



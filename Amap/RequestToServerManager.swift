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
  
  func requestForAgencyData(functionToMakeWhenBringInfo: ()-> Void) {
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
          
          //print(json)
          
          AgencyModel.Data.address = json["address"] as? String
          AgencyModel.Data.contact_email = json["contact_email"] as? String
          AgencyModel.Data.contact_name = json["contact_name"] as? String
          AgencyModel.Data.latitude = json["latitude"] as? String
          AgencyModel.Data.logo = json["logo"] as? String
          AgencyModel.Data.longitude = json["longitude"] as? String
          AgencyModel.Data.name = json["name"] as? String
          let numberOfEmployees = json["num_employees"] as? Int
          if numberOfEmployees != nil {
            AgencyModel.Data.num_employees = String(numberOfEmployees!)
          }
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
          
          var arrayOfRawSkills: [AnyObject]! = nil
          
          if json["skills"] as? [AnyObject] != nil {
            
            arrayOfRawSkills = json["skills"] as! [AnyObject]
          
          }
        
//          print(arrayOfRawSkills)
          
          if arrayOfRawSkills != nil {
            
            AgencyModel.Data.skillsLevel = [Skill]()
          
            for skill in arrayOfRawSkills! {
              
              let newSkill = Skill.init(id: String(skill["id"] as! Int),
                nameSkill: skill["name"] as! String,
                levelSkill: (skill["level"] as? Int != nil ? skill["level"] as! Int : 0),
                skill_category_id: (skill["skill_category_id"] as? Int != nil ? (skill["skill_category_id"] as! Int) : nil))
              
              AgencyModel.Data.skillsLevel?.append(newSkill)
            
            }
          }
          
          functionToMakeWhenBringInfo()
          
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
        var newCaseImageUrlThumb: String! = nil
        var newCaseAgencyId: String! = nil
        
//        print("Case: \(rawCase)")
        
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
        if rawCase["case_image_thumb"] as? String != nil {
          newCaseImageUrlThumb = rawCase["case_image_thumb"] as! String
        }
        if rawCase["agency_id"] as? String != nil {
          newCaseAgencyId = rawCase["agency_id"] as! String
        }
        
        let newCase = Case(id: newCaseId,
                           name: newCaseName,
                           description: newCaseDescription,
                           url: newCaseUrl,
                           case_image_url: newCaseImageUrl,
                           case_image_thumb: newCaseImageUrlThumb,
                           case_image: nil,
                           agency_id: newCaseAgencyId)
        
        allCases.append(newCase)
        
      }
      
      AgencyModel.Data.success_cases = allCases
      //      print("CASES IN AGENCY MODEL: \(AgencyModel.Data.success_cases)")
      
    }
    
  }

  func requestForDeleteAgencyCase(caseData: Case, actionToMakeAfterDelete: () -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/success_cases/destroy"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    //print(caseData)
    
    let params = ["id" : caseData.id,
                  "auth_token" : UserSession.session.auth_token
                  ]
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 204 {
          
          actionToMakeAfterDelete()
          
        }else{
          print("ERROR DELETING CASE")
        }
        
    }
    
  }

  func requestToGetAllSkillsCategories(functionToMakeWhenFinished: (jsonOfSkills: AnyObject?) -> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/skill_categories"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {

          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          functionToMakeWhenFinished(jsonOfSkills: json)
          
        }
    }
  }
  
  func requestToSaveDataFromSkills(params: [String:AnyObject]) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies/add_skills"
    
//    print(params)
//    
//    let auth_token = params["auth_token"]
//    let agency_id = params["id"]
//    let skills: Array<[String:String]> = params["skills"] as! Array<[String:String]>
//    
//    let data = [
//      params
//    ]
//    var jsonData: NSData?
//    do {
//      jsonData = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//      print(jsonData)
//      // here "jsonData" is the dictionary encoded in JSON data
//    } catch let error as NSError {
//      print(error)
//    }
//    
//    print(data)
    
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
//    if jsonData != nil {
//      
//      requestConnection.HTTPBody = jsonData!
//      
//    }
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      //      .response{
      //        (request, response, data, error) -> Void in
      //        print(response)
      ////          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
      ////            print (json)
      ////          }
      
      .responseJSON{ response in
        print("RESPONSE JSON SKILLS")
        print(response)
        
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)

          } else {
            
            print("ERROR")
            
          }
      }
  }
  
  func logOut(actionsToMakeAfterSuccesfullLogOut: ()-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/sessions/destroy"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    var values: [String:String]
    
    if UserSession.session.auth_token != nil {
    
    values = [
      "id": UserSession.session.auth_token
    ]
    
    } else {
    
      values = ["id": "bla"]//Supposedly never happend
    
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 204 {
          
          actionsToMakeAfterSuccesfullLogOut()
   
        }else {
            
            print("ERROR")
            
        }
    }
  }

}



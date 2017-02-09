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
            
            if numberOfEmployees == 1 {
              
              AgencyModel.Data.num_employees = "Chica"
              
            }else
              if numberOfEmployees == 2 {
                
                AgencyModel.Data.num_employees = "Mediana"
                
            }else
              if numberOfEmployees == 3 {
              
                AgencyModel.Data.num_employees = "Grande"
                
            }
            
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
                skill_category_id: (skill["skill_category_id"] as? Int != nil ? (String(skill["skill_category_id"] as! Int)) : nil))
              
              AgencyModel.Data.skillsLevel?.append(newSkill)
            
            }
          }
          
          let criteria = json["criteria"] as? Array<[String: AnyObject]>
          
          if criteria != nil {
            
            var arrayOfCriterion = [CriteriaModelData]()
            
            for criterion in criteria! {
              
              let criterionId = (criterion["id"] as? Int != nil ? String(criterion["id"] as! Int) : "-1")
              let criterionName = (criterion["name"] as? String != nil ? criterion["name"] as! String : "Nombre de criterio")
              
              let newCriterion = CriteriaModelData()
              newCriterion.id = criterionId
              newCriterion.name = criterionName
                
              arrayOfCriterion.append(newCriterion)
              
            }
            
            AgencyModel.Data.criteria = arrayOfCriterion
            
          }
          
          let exclusivityBrands = json["exclusivity_brands"] as? Array<[String: AnyObject]>
          
          if exclusivityBrands != nil {
            
            var arrayOfExclusivityBrands = [ExclusivityBrandModelData]()
            
            for brand in exclusivityBrands! {
              
              let newBrandName = (brand["brand"] as? String != nil ? brand["brand"] as! String : "New Brand no name")
              let newBrandId = (brand["id"] as? Int != nil ? String(brand["id"] as! Int) : "-1")
              
              let newExclusivityBrand = ExclusivityBrandModelData.init(newId: newBrandId,
                newName: newBrandName)
              
              arrayOfExclusivityBrands.append(newExclusivityBrand)
              
            }
            
            AgencyModel.Data.exclusivityBrands = arrayOfExclusivityBrands
            
          }
          
          functionToMakeWhenBringInfo()
//          UtilityManager.sharedInstance.hideLoader()
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
        var newCaseVideoUrl: String! = nil
        
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
        if rawCase["video_url"] as? String != nil {
          newCaseVideoUrl = rawCase["video_url"] as! String
        }else{
          newCaseVideoUrl = ""
        }
        
        let newCase = Case(id: newCaseId,
                           name: newCaseName,
                           description: newCaseDescription,
                           url: newCaseUrl,
                           case_image_url: newCaseImageUrl,
                           case_image_thumb: newCaseImageUrlThumb,
                           case_image: nil,
                           case_video_url: newCaseVideoUrl,
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
    
//    UtilityManager.sharedInstance.showLoader()
    
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
          
        } else {
          
          print("ERROR WHEN GET SKILL CATEGORIES: \(response)")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
  }
  
  
  func requestToSaveDataFromCriterions(params: [String:AnyObject], actionsToMakeAfterFinished: () -> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies/add_criteria"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)

      
      .responseJSON{ response in
        print("RESPONSE JSON CRITERIONS")
        print(response)
        
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          actionsToMakeAfterFinished()
          
        } else {
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR")
          
        }
    }
  }
  
  

  func requestToGetAllCriterions(functionToMakeWhenFinished: (criteria: [CriteriaModelData]) -> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/criteria"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {

          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let criteria = json["criteria"] as? Array<[String: AnyObject]>
          
          var arrayOfCriterion = [CriteriaModelData]()
          
          for criterion in criteria! {
            
            let criterionId = (criterion["id"] as? Int != nil ? String(criterion["id"] as! Int) : "-1")
            let criterionName = (criterion["name"] as? String != nil ? criterion["name"] as! String : "Nombre de criterio")
            
            let newCriterion = CriteriaModelData()
            newCriterion.id = criterionId
            newCriterion.name = criterionName
            
            arrayOfCriterion.append(newCriterion)
            
          }
          
          functionToMakeWhenFinished(criteria: arrayOfCriterion)
          
        } else {
          
          print("ERROR WHEN GET ALL CRITERIA: \(response)")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
  }
  
  func requestToSaveDataFromSkills(params: [String:AnyObject], actionsToMakeAfterFinished: () -> Void) {
    
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
          
          actionsToMakeAfterFinished()

          } else {
          
          UtilityManager.sharedInstance.hideLoader()
            print("ERROR")
            actionsToMakeAfterFinished()
          }
      }
  }
  
  func requestForCompanyData(functionToMakeWhenFinished: () -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/companies/" + UserSession.session.company_id
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
      
          let idCompany = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          let companyName = (json["name"] as? String != nil ? json["name"] as! String : "")
          let contactName = (json["contact_name"] as? String != nil ? json["contact_name"] as! String : "")
          let contactEMail = (json["contact_email"] as? String != nil ? json["contact_email"] as! String : "")
          let contactPosition = (json["contact_position"] as? String != nil ? json["contact_position"] as! String : "")
          let logoURL = (json["logo"] as? String != nil ? json["logo"] as! String : "")
          let brands = (json["brands"] as? Array<[String: AnyObject]> != nil ? json["brands"] as? Array<[String: AnyObject]> : nil)
              
          let arrayOfBrands = self.getAllBrandsFromRaw(brands, proprietaryCompanyID: idCompany)
              
          MyCompanyModelData.Data.id = idCompany
          MyCompanyModelData.Data.name = companyName
          MyCompanyModelData.Data.contactName = contactName
          MyCompanyModelData.Data.contactEMail = contactEMail
          MyCompanyModelData.Data.contactPosition = contactPosition
          MyCompanyModelData.Data.logoURL = logoURL
          MyCompanyModelData.Data.brands = arrayOfBrands

          functionToMakeWhenFinished()
            
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
  }

  
  func requestToGetAllCompanies(functionToMakeWhenFinished: (allCompanies:[CompanyModelData]) -> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/companies"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
          
          let companies = json["companies"] as? Array<[String: AnyObject]>
            
          if companies != nil {
            
            var arrayOfCompanies = [CompanyModelData]()
              
            for company in companies! {
            
              let companyName = (company["name"] as? String != nil ? company["name"] as! String : "No Name")
              let idCompany = (company["id"] as? Int != nil ? String(company["id"] as! Int) : "-1")
              let brands = (company["brands"] as? Array<[String: AnyObject]> != nil ? company["brands"] as? Array<[String: AnyObject]> : nil)
              
              let arrayOfBrands = self.getAllBrandsFromRaw(brands, proprietaryCompanyID: idCompany)
              
              let newCompany = CompanyModelData.init(newId: idCompany,
                newName: companyName,
                newBrands: arrayOfBrands)
              
              arrayOfCompanies.append(newCompany)
                
            }
            
            functionToMakeWhenFinished(allCompanies: arrayOfCompanies)

          }
          
//          functionToMakeWhenFinished(allCompanies: [CompanyModelData]())
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
  }
  
  private func getAllBrandsFromRaw(data: Array<[String: AnyObject]>?, proprietaryCompanyID: String!) -> [BrandModelData] {
  
    var arrayOfBrands = [BrandModelData]()
    if data != nil {
      
      for brand in data! {
        
        let brandId = (brand["id"] as? Int != nil ? String(brand["id"] as! Int) : "-1")
        let brandName = (brand["name"] as? String != nil ? brand["name"] as! String : "No name")
//        let contactName = (brand["contact_name"] as? String != nil ? brand["contact_name"] as! String : "No_contact_name")
//        let contactEMail = (brand["contact_email"] as? String != nil ? brand["contact_email"] as! String : "No_contact_email")
//        let contactPosition = (brand["contact_position"] as? String != nil ? brand["contact_position"] as! String : "No_contact_position")
//        
//        let proprietaryCompanyData = (brand["company"] as? [String: AnyObject] != nil ? brand["company"] as! [String: AnyObject] : [String: AnyObject]())
//        
//        var proprietaryCompanyID: String! = nil
//        
//        if proprietaryCompanyData["id"] as? Int != nil {
//            
//          proprietaryCompanyID = String(proprietaryCompanyData["id"] as! Int)
//            
//        } else {
//          //supossedly never happen
//          proprietaryCompanyID = "-1"
//          
//        }
        
        let newBrand = BrandModelData.init(newId: brandId,
                                         newName: brandName,
                                  newContactName: nil,
                                 newContactEMail: nil,
                              newContactPosition: nil,
                           newProprietaryCompany: nil)
        
        arrayOfBrands.append(newBrand)
        
        }
    }
    return arrayOfBrands
      
  }
  
  func requestToGetAllAgencies(functionToMakeWhenFinished: (allAgencies:[GenericAgencyData]) -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
          
          let agencies = json["agencies"] as? Array<[String: AnyObject]>
          
          if agencies != nil {
            
            var arrayOfAgencies = [GenericAgencyData]()
            
            for agency in agencies! {
//
              let agencyName = (agency["name"] as? String != nil ? agency["name"] as! String : "No Name")
              let agencyId = (agency["id"] as? Int != nil ? String(agency["id"] as! Int) : "-1")
              
              //CHECK THIS
              let isFavorite = (agency["is_favorite"] as? Bool != nil ? agency["is_favorite"] as! Bool : false)

              let newAgency = GenericAgencyData(newId: agencyId,
                newName: agencyName,
                newIsFavorite: isFavorite)
              
              arrayOfAgencies.append(newAgency)
              
            }
          
            functionToMakeWhenFinished(allAgencies: arrayOfAgencies)
          
          }
          
          //          functionToMakeWhenFinished(allCompanies: [CompanyModelData]())
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
  }
  
  func requestToGetAgenciesBySearch(parameters: [String: AnyObject], functionToMakeWhenFinished: (allAgencies:[GenericAgencyData]) -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies/search"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
          
          let agencies = json["agencies"] as? Array<[String: AnyObject]>
          
          if agencies != nil {
            
            var arrayOfAgencies = [GenericAgencyData]()
            
            for agency in agencies! {
              //
              let agencyName = (agency["name"] as? String != nil ? agency["name"] as! String : "No Name")
              let agencyId = (agency["id"] as? Int != nil ? String(agency["id"] as! Int) : "-1")
              
              //CHECK THIS
              let isFavorite = (agency["is_favorite"] as? Bool != nil ? agency["is_favorite"] as! Bool : false)
              
              let newAgency = GenericAgencyData(newId: agencyId,
                newName: agencyName,
                newIsFavorite: isFavorite)
              
              arrayOfAgencies.append(newAgency)
              
            }
            
            functionToMakeWhenFinished(allAgencies: arrayOfAgencies)
            
          }
          
          //          functionToMakeWhenFinished(allCompanies: [CompanyModelData]())
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
  }
  
  func requestToSearchPitch(params: [String: AnyObject], functionToMakeAfterSearching: (allPitches: [PitchEvaluationByUserModelData]) -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/search"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
          
          let arrayOfPitchEvaluationByUserModelData = json as? Array<[String: AnyObject]>
          
          if arrayOfPitchEvaluationByUserModelData != nil {
            
            if UserSession.session.role == "2" || UserSession.session.role == "3" {
              
              var newArrayOfPitchesByUser = [PitchEvaluationByUserModelData]()
              
              for pitchEvaluationByUser in arrayOfPitchEvaluationByUserModelData! {
                
                let newPitchEvaluationId = (pitchEvaluationByUser["pitch_evaluation_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_evaluation_id"] as! Int) : "-1")
                let newPitchId = (pitchEvaluationByUser["pitch_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_id"] as! Int) : "-1")
                let newPitchName = (pitchEvaluationByUser["pitch_name"] as? String != nil ? pitchEvaluationByUser["pitch_name"] as! String : "No Pitch Name")
                let newBriefDate = (pitchEvaluationByUser["brief_date"] as? String != nil ? pitchEvaluationByUser["brief_date"] as! String : "01/01/1900")
                let newScore = (pitchEvaluationByUser["score"] as? Int != nil ? pitchEvaluationByUser["score"] as! Int : -1)
                let newBrandName = (pitchEvaluationByUser["brand"] as? String != nil ? pitchEvaluationByUser["brand"] as! String : "No Brand Name")
                let newCompanyName = (pitchEvaluationByUser["company"] as? String != nil ? pitchEvaluationByUser["company"] as! String : "No Company Name")
                let newOtherScores = (pitchEvaluationByUser["other_scores"] as? [Int] != nil ? pitchEvaluationByUser["other_scores"] as! [Int] : [Int]())
                var newWasWon: Bool! = nil
                newWasWon = (pitchEvaluationByUser["was_won"] as? Bool != nil ? pitchEvaluationByUser["was_won"] as! Bool : nil)
                let newPitchStatus = (pitchEvaluationByUser["pitch_status"] as? Int != nil ? pitchEvaluationByUser["pitch_status"] as! Int : 4) //4 is for archived, i'll ask this to client in future
                let newPitchEvaluationStatus = (pitchEvaluationByUser["evaluation_status"] as? Bool != nil ? pitchEvaluationByUser["evaluation_status"] as! Bool : false)
                let newHasResults = (pitchEvaluationByUser["has_results"] as? Bool != nil ? pitchEvaluationByUser["has_results"] as! Bool : false)
                let newHasPitchWinnerSurvey = (pitchEvaluationByUser["has_pitch_winner_survey"] as? Bool != nil ? pitchEvaluationByUser["has_pitch_winner_survey"] as! Bool : false)
                let newPitchsResultsId = (pitchEvaluationByUser["pitch_results_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_results_id"] as! Int) : "-1")
                
                
                
                let arrayOfEvaluationPitchSkillCategories = (pitchEvaluationByUser["skill_categories"] as? Array<[String: AnyObject]> != nil ? pitchEvaluationByUser["skill_categories"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
                
                var newArrayOfEvaluationSkillCategoryModelData = [EvaluationPitchSkillCategoryModelData]()
                
                if arrayOfEvaluationPitchSkillCategories.count > 0 {
                  
                  for evaluationSkillCategory in arrayOfEvaluationPitchSkillCategories {
                    
                    let newEvaluationPitchSkillCategoryID = (evaluationSkillCategory["id"] as? Int != nil ? String(evaluationSkillCategory["id"] as! Int) : "-1")
                    let newEvaluationPitchSkillCategoryName = (evaluationSkillCategory["name"] as? String != nil ? evaluationSkillCategory["name"] as! String : "Skill Category NO NAME")
                    
                    let newEvaluationPitchSkillCategory = EvaluationPitchSkillCategoryModelData.init(newEvaluationSkillCategoryId: newEvaluationPitchSkillCategoryID,
                      newEvaluationSkillCategoryName: newEvaluationPitchSkillCategoryName)
                    
                    newArrayOfEvaluationSkillCategoryModelData.append(newEvaluationPitchSkillCategory)
                    
                  }
                  
                }
                
                let newPitchEvaluationByUser = PitchEvaluationByUserModelData.init(
                  newPitchEvaluationId: newPitchEvaluationId,
                  newPitchId: newPitchId,
                  newPitchName: newPitchName,
                  newBriefDate: newBriefDate,
                  newScore: newScore,
                  newBrandName: newBrandName,
                  newCompanyName: newCompanyName,
                  newOtherScores: newOtherScores,
                  newArrayOfEvaluationPitchSkillCategory: newArrayOfEvaluationSkillCategoryModelData,
                  newWasWon: newWasWon,
                  newPitchStatus: newPitchStatus,
                  newEvaluationStatus: newPitchEvaluationStatus,
                  newHasResults: newHasResults,
                  newHasPitchWinnerSurvey: newHasPitchWinnerSurvey,
                  newPitchResultsId: newPitchsResultsId)
                
                newArrayOfPitchesByUser.append(newPitchEvaluationByUser)
                
              }
              
              functionToMakeAfterSearching(allPitches: newArrayOfPitchesByUser)
              
//              actionsToMakeAfterFinished(pitchEvaluationsByUser: newArrayOfPitchesByUser, pitchesForCompany: nil)
              
            } else
              
              if UserSession.session.role == "4" || UserSession.session.role == "5"  {
                
                var newArrayOfPitchesByUserForCompany = [PitchEvaluationByUserModelDataForCompany]()
                
                let arrayOfPitchEvaluationByUserModelDataForCompany = arrayOfPitchEvaluationByUserModelData
                
                for pitchEvaluationForCompany in arrayOfPitchEvaluationByUserModelDataForCompany! {
                  
                  let newBrandName = (pitchEvaluationForCompany["brand"] as? String != nil ? pitchEvaluationForCompany["brand"] as! String : "No brand name")
                  let newBriefDate = (pitchEvaluationForCompany["brief_date"] as? String != nil ? pitchEvaluationForCompany["brief_date"] as! String : "01/01/1900")
                  let newBriefEmailContact = (pitchEvaluationForCompany["brief_email_contact"] as? String != nil ? pitchEvaluationForCompany["brief_email_contact"] as! String : "noBriefContact@mail.com")
                  let newCompanyName = (pitchEvaluationForCompany["company"] as? String != nil ? pitchEvaluationForCompany["company"] as! String : "No company name")
                  let newPitchID = (pitchEvaluationForCompany["pitch_id"] as? Int != nil ? String(pitchEvaluationForCompany["pitch_id"] as! Int) : "-1")
                  let newPitchName = (pitchEvaluationForCompany["pitch_name"] as? String != nil ? pitchEvaluationForCompany["pitch_name"] as! String : "No Pitch Name")
                  let newWinner = (pitchEvaluationForCompany["winner"] as? Int != nil ? String(pitchEvaluationForCompany["winner"] as! Int) : "-1")
                  
                  let newBreakDown = (pitchEvaluationForCompany["breakdown"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["breakdown"] as! [String: AnyObject] : [String: AnyObject]())
                  
                  let newPitchesTypesPercentage = (pitchEvaluationForCompany["pitch_types_percentage"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["pitch_types_percentage"] as! [String: AnyObject] : [String: AnyObject]())
                  
                  let newPitchEvaluationForCompany = PitchEvaluationByUserModelDataForCompany.init(newBrandName: newBrandName,
                    newBreakDown: newBreakDown,
                    newBriefDate: newBriefDate,
                    newBriefEmailContact: newBriefEmailContact,
                    newCompanyName: newCompanyName,
                    newPitchId: newPitchID,
                    newPitchName: newPitchName,
                    newPitchTypesPercentage: newPitchesTypesPercentage,
                    newWinner: newWinner)
                  
                  newArrayOfPitchesByUserForCompany.append(newPitchEvaluationForCompany)
                  
                }
                
//                actionsToMakeAfterFinished(pitchEvaluationsByUser: nil, pitchesForCompany: newArrayOfPitchesByUserForCompany)
                
                
                print(json)
                
                
                
                
                
                
                
                
                
                
                
                
            }
            
            
            
          }//
          
          
          
          
//          let agencies = json["agencies"] as? Array<[String: AnyObject]>
//          
//          if agencies != nil {
//            
//            var arrayOfAgencies = [GenericAgencyData]()
//            
////            functionToMakeAfterSearching
//            
//          }
    
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
  }
  
  func requestToGetAllProjectsPitches(byBrandId: String!, functionToMakeWhenFinished: (allProjects:[ProjectPitchModelData]) -> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitches/by_brand/\(byBrandId)"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        print()
        if response.response?.statusCode == 422 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          let error = (json["errors"] as? String != nil ? json["errors"] as! String : "")
          if error == "No se encontraron proyecto para la marca con id: \(byBrandId)" {
    
            functionToMakeWhenFinished(allProjects: [ProjectPitchModelData]())
            
          }
          
          UtilityManager.sharedInstance.hideLoader()
    
        } else
        
        if response.response?.statusCode == 200 {
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          print(json)
          
          print()
          
          let projectsPitches = json as? Array<[String: AnyObject]>
          
          if projectsPitches != nil {
            
            var arrayOfProjectPitches = [ProjectPitchModelData]()
            
            for projectPitch in projectsPitches! {
              
              let projectPitchName = (projectPitch["name"] as? String != nil ? projectPitch["name"] as! String : "Nombre Pitch")
              let projectPitchId = (projectPitch["id"] as? Int != nil ? String(projectPitch["id"] as! Int) : "-1")
              let projectBriefDate = (projectPitch["brief_date"] as? String != nil ? projectPitch["brief_date"] as! String : "01/01/1900")
              let projectPitchBriefEMailContact = (projectPitch["brief_email_contact"] as? String != nil ? projectPitch["brief_email_contact"] as! String : "briefContact@contact.com")
              
              var arrayOfCategories = [PitchSkillCategory]()
              
              let categories = projectPitch["skill_categories"] as? Array<[String:AnyObject]>
              
              if categories != nil {
                
                for category in categories! {
                  
                  var categoryId:String!
                  if category["id"] as? Int != nil {
                    categoryId = String(category["id"] as! Int)
                  }
                  let categoryName = category["name"] as! String
                  
                  let newProjectPitchSkillCategory = PitchSkillCategory(newPitchSkillCategoryId: categoryId,
                    newSkillCategoryName: categoryName,
                    newIsThisCategory: true,
                    newSkills: [Skill]())
                  
                  arrayOfCategories.append(newProjectPitchSkillCategory)
                  
                }
                
              }
              
              let brandInfo = projectPitch["brand"] as? [String: AnyObject]
              
              var projectPitchBrandId = "-1"
              
              if brandInfo != nil {
                
                projectPitchBrandId = (brandInfo!["id"] as? Int != nil ? String(brandInfo!["id"] as! Int) : "-1")
                
              }
              
              let newProjectPitch = ProjectPitchModelData(newId: projectPitchId,
                newName: projectPitchName,
                newBrandId: projectPitchBrandId,
                newBriefDate: projectBriefDate,
                newBrieEMailContact: projectPitchBriefEMailContact,
                newArrayOfPitchCategories: arrayOfCategories)
              
              arrayOfProjectPitches.append(newProjectPitch)
              
            }
            
            functionToMakeWhenFinished(allProjects: arrayOfProjectPitches)
            
          }
          
        }
    }
    
  }
  
  func requestToSaveExclusiveBrands(params: [String: AnyObject], actionsToMakeAfterSuccesfullCreateNewBrand: (jsonSentFromServerWhenSaveExclusiveData: AnyObject)-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies/add_exclusivity_brands"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          actionsToMakeAfterSuccesfullCreateNewBrand(jsonSentFromServerWhenSaveExclusiveData: json)
          
        } else
          if response.response?.statusCode == 422 {
          
            let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
            
            let message = (json["errors"] as? String != nil ? json["errors"] as! String : "")
            
            if message == "No se encontró ninguna marca de exclusividad" {
              
              actionsToMakeAfterSuccesfullCreateNewBrand(jsonSentFromServerWhenSaveExclusiveData: json)
              
            }
            
          } else {
            
            UtilityManager.sharedInstance.hideLoader()
            print ("ERROR WHEN CREATE EXCLUSIVITY BRANDS")
            
        }
    }
  }
  
  func requestToDeleteExclusiveBrands(params: [String: AnyObject], actionsToMakeAfterSuccesfullDeleteBrands: (jsonSentFromServerWhenDeleteExclusiveBrandsData: AnyObject)-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/agencies/remove_exclusivity_brands"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          actionsToMakeAfterSuccesfullDeleteBrands(jsonSentFromServerWhenDeleteExclusiveBrandsData: json)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  
  func requestToGetAllPitchEvaluationByUser(actionsToMakeAfterFinished: (pitchEvaluationsByUser: [PitchEvaluationByUserModelData]?, pitchesForCompany: [PitchEvaluationByUserModelDataForCompany]?) -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/by_user"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
 
    let params = [
                  "auth_token": UserSession.session.auth_token
                 ]
    
    
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
        print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          let arrayOfPitchEvaluationByUserModelData = json as? Array<[String: AnyObject]>
          
          if arrayOfPitchEvaluationByUserModelData != nil {
            
            if UserSession.session.role == "2" || UserSession.session.role == "3" {
            
              var newArrayOfPitchesByUser = [PitchEvaluationByUserModelData]()
              
              for pitchEvaluationByUser in arrayOfPitchEvaluationByUserModelData! {
                
                let newPitchEvaluationId = (pitchEvaluationByUser["pitch_evaluation_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_evaluation_id"] as! Int) : "-1")
                let newPitchId = (pitchEvaluationByUser["pitch_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_id"] as! Int) : "-1")
                let newPitchName = (pitchEvaluationByUser["pitch_name"] as? String != nil ? pitchEvaluationByUser["pitch_name"] as! String : "No Pitch Name")
                let newBriefDate = (pitchEvaluationByUser["brief_date"] as? String != nil ? pitchEvaluationByUser["brief_date"] as! String : "01/01/1900")
                let newScore = (pitchEvaluationByUser["score"] as? Int != nil ? pitchEvaluationByUser["score"] as! Int : -1)
                let newBrandName = (pitchEvaluationByUser["brand"] as? String != nil ? pitchEvaluationByUser["brand"] as! String : "No Brand Name")
                let newCompanyName = (pitchEvaluationByUser["company"] as? String != nil ? pitchEvaluationByUser["company"] as! String : "No Company Name")
                let newOtherScores = (pitchEvaluationByUser["other_scores"] as? [Int] != nil ? pitchEvaluationByUser["other_scores"] as! [Int] : [Int]())
                var newWasWon: Bool! = nil
                newWasWon = (pitchEvaluationByUser["was_won"] as? Bool != nil ? pitchEvaluationByUser["was_won"] as! Bool : nil)
                let newPitchStatus = (pitchEvaluationByUser["pitch_status"] as? Int != nil ? pitchEvaluationByUser["pitch_status"] as! Int : 4) //4 is for archived, i'll ask this to client in future
                let newPitchEvaluationStatus = (pitchEvaluationByUser["evaluation_status"] as? Bool != nil ? pitchEvaluationByUser["evaluation_status"] as! Bool : false)
                let newHasResults = (pitchEvaluationByUser["has_results"] as? Bool != nil ? pitchEvaluationByUser["has_results"] as! Bool : false)
                let newHasPitchWinnerSurvey = (pitchEvaluationByUser["has_pitch_winner_survey"] as? Bool != nil ? pitchEvaluationByUser["has_pitch_winner_survey"] as! Bool : false)
                let newPitchsResultsId = (pitchEvaluationByUser["pitch_results_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_results_id"] as! Int) : "-1")
                
                let arrayOfEvaluationPitchSkillCategories = (pitchEvaluationByUser["skill_categories"] as? Array<[String: AnyObject]> != nil ? pitchEvaluationByUser["skill_categories"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
                
                var newArrayOfEvaluationSkillCategoryModelData = [EvaluationPitchSkillCategoryModelData]()
                
                if arrayOfEvaluationPitchSkillCategories.count > 0 {
                  
                  for evaluationSkillCategory in arrayOfEvaluationPitchSkillCategories {
                    
                    let newEvaluationPitchSkillCategoryID = (evaluationSkillCategory["id"] as? Int != nil ? String(evaluationSkillCategory["id"] as! Int) : "-1")
                    let newEvaluationPitchSkillCategoryName = (evaluationSkillCategory["name"] as? String != nil ? evaluationSkillCategory["name"] as! String : "Skill Category NO NAME")
                    
                    let newEvaluationPitchSkillCategory = EvaluationPitchSkillCategoryModelData.init(newEvaluationSkillCategoryId: newEvaluationPitchSkillCategoryID,
                      newEvaluationSkillCategoryName: newEvaluationPitchSkillCategoryName)
                    
                    newArrayOfEvaluationSkillCategoryModelData.append(newEvaluationPitchSkillCategory)
                    
                  }
                  
                }
                
                var arrayOfRecommendations = [RecommendationModelData]()
                
                let recommendationsFromServer = (pitchEvaluationByUser["recommendations"] as? Array<[String: AnyObject]> != nil ? pitchEvaluationByUser["recommendations"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
                
                for recommendation in recommendationsFromServer {
                  
                  let newBody = (recommendation["body"] as? String != nil ? recommendation["body"] as! String : "")
                  let newRecoId = (recommendation["reco_id"] as? String != nil ? recommendation["reco_id"] as! String : "")
                  
                  var nameOfIcon = ""
                  if newRecoId != "" {
                    
                    if newRecoId == "client_objective_25" {
                      
                      nameOfIcon = "communication"
                      
                    }else
                      
                      if newRecoId == "client_objective_50" {
                        
                        nameOfIcon = "communication"
                        
                      }else
                        
                        if newRecoId == "client_objective_75" {
                          
                          nameOfIcon = "list"
                          
                        }else
                          
                          if newRecoId == "client_budget_25" {
                            
                            nameOfIcon = "budget"
                            
                          }else
                            
                            if newRecoId == "client_budget_50" {
                              
                              nameOfIcon = "budget"
                              
                            }else
                              
                              if newRecoId == "client_budget_75" {
                                
                                nameOfIcon = "budget"
                                
                              }else
                                
                                if newRecoId == "client_budget_100" {
                                  
                                  nameOfIcon = "budget"
                                  
                                }else
                                  
                                  if newRecoId == "client_criteria" {
                                    
                                    nameOfIcon = "criteria"
                                    
                                  }else
                                    
                                    if newRecoId == "client_number_5" {
                                      
                                      nameOfIcon = "eye"
                                      
                                    }else
                                      
                                      if newRecoId == "client_number_7" {
                                        
                                        nameOfIcon = "number"
                                        
                                      }else
                                        
                                        if newRecoId == "client_time" {
                                          
                                          nameOfIcon = "time"
                                          
                                        }else
                                          
                                          if newRecoId == "client_more_time" {
                                            
                                            nameOfIcon = "more_time"
                                            
                                          }else
                                            
                                            if newRecoId == "client_property" {
                                              
                                              nameOfIcon = "property"
                                              
                                            }else
                                              
                                              if newRecoId == "client_deliverable_25" {
                                                
                                                nameOfIcon = "deliverable"
                                                
                                              }else
                                                
                                                if newRecoId == "client_deliverable_50" {
                                                  
                                                  nameOfIcon = "deliverable"
                                                  
                                                }else
                                                  
                                                  if newRecoId == "client_deliverable_75" {
                                                    
                                                    nameOfIcon = "deliverable"
                                                    
                                                  }else
                                                    
                                                    if newRecoId == "client_deliverable_100" {
                                                      
                                                      nameOfIcon = "deliverable"
                                                      
                    }
                    
                  }
                  
                  let newRecommendation = RecommendationModelData.init(newBody: newBody,
                    newRecoId: newRecoId)
                  newRecommendation.iconName = nameOfIcon
                  
                  arrayOfRecommendations.append(newRecommendation)
                  
                }

                let newPitchEvaluationByUser = PitchEvaluationByUserModelData.init(
                  newPitchEvaluationId: newPitchEvaluationId,
                  newPitchId: newPitchId,
                  newPitchName: newPitchName,
                  newBriefDate: newBriefDate,
                  newScore: newScore,
                  newBrandName: newBrandName,
                  newCompanyName: newCompanyName,
                  newOtherScores: newOtherScores,
                  newArrayOfEvaluationPitchSkillCategory: newArrayOfEvaluationSkillCategoryModelData,
                  newWasWon: newWasWon,
                  newPitchStatus: newPitchStatus,
                  newEvaluationStatus: newPitchEvaluationStatus,
                  newHasResults: newHasResults,
                  newHasPitchWinnerSurvey: newHasPitchWinnerSurvey,
                  newPitchResultsId: newPitchsResultsId)
                
                newPitchEvaluationByUser.arrayOfRecommendations = arrayOfRecommendations
                
                newArrayOfPitchesByUser.append(newPitchEvaluationByUser)
                
              }
              
              actionsToMakeAfterFinished(pitchEvaluationsByUser: newArrayOfPitchesByUser, pitchesForCompany: nil)
            
            } else
            
              if UserSession.session.role == "4" || UserSession.session.role == "5"  {
                
                var newArrayOfPitchesByUserForCompany = [PitchEvaluationByUserModelDataForCompany]()
                
                let arrayOfPitchEvaluationByUserModelDataForCompany = arrayOfPitchEvaluationByUserModelData
                
                for pitchEvaluationForCompany in arrayOfPitchEvaluationByUserModelDataForCompany! {
                  
                  let newBrandName = (pitchEvaluationForCompany["brand"] as? String != nil ? pitchEvaluationForCompany["brand"] as! String : "No brand name")
                  let newBriefDate = (pitchEvaluationForCompany["brief_date"] as? String != nil ? pitchEvaluationForCompany["brief_date"] as! String : "01/01/1900")
                  let newBriefEmailContact = (pitchEvaluationForCompany["brief_email_contact"] as? String != nil ? pitchEvaluationForCompany["brief_email_contact"] as! String : "noBriefContact@mail.com")
                  let newCompanyName = (pitchEvaluationForCompany["company"] as? String != nil ? pitchEvaluationForCompany["company"] as! String : "No company name")
                  let newPitchID = (pitchEvaluationForCompany["pitch_id"] as? Int != nil ? String(pitchEvaluationForCompany["pitch_id"] as! Int) : "-1")
                  let newPitchName = (pitchEvaluationForCompany["pitch_name"] as? String != nil ? pitchEvaluationForCompany["pitch_name"] as! String : "No Pitch Name")
                  let newWinner = (pitchEvaluationForCompany["winner"] as? Int != nil ? String(pitchEvaluationForCompany["winner"] as! Int) : "-1")
                  
                  let newBreakDown = (pitchEvaluationForCompany["breakdown"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["breakdown"] as! [String: AnyObject] : [String: AnyObject]())
                  
                  let newPitchesTypesPercentage = (pitchEvaluationForCompany["pitch_types_percentage"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["pitch_types_percentage"] as! [String: AnyObject] : [String: AnyObject]())
                  
                  var arrayOfRecommendations = [RecommendationModelData]()
                  
                  let recommendationsFromServer = (pitchEvaluationForCompany["recommendations"] as? Array<[String: AnyObject]> != nil ? pitchEvaluationForCompany["recommendations"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
                  
                  for recommendation in recommendationsFromServer {
                    
                    let newBody = (recommendation["body"] as? String != nil ? recommendation["body"] as! String : "")
                    let newRecoId = (recommendation["reco_id"] as? String != nil ? recommendation["reco_id"] as! String : "")
                    
                    var nameOfIcon = ""
                    if newRecoId != "" {
                      
                      if newRecoId == "client_objective_25" {
                        
                        nameOfIcon = "communication"
                        
                      }else
                      
                      if newRecoId == "client_objective_50" {
                          
                        nameOfIcon = "communication"
                          
                      }else
                      
                      if newRecoId == "client_objective_75" {
                            
                        nameOfIcon = "list"
                            
                      }else
                      
                      if newRecoId == "client_budget_25" {
                          
                        nameOfIcon = "budget"
                          
                      }else
                        
                      if newRecoId == "client_budget_50" {
                              
                        nameOfIcon = "budget"
                              
                      }else
                        
                      if newRecoId == "client_budget_75" {
                          
                        nameOfIcon = "budget"
                          
                      }else
                      
                      if newRecoId == "client_budget_100" {
                          
                        nameOfIcon = "budget"
                          
                      }else
                        
                      if newRecoId == "client_criteria" {
                          
                        nameOfIcon = "criteria"
                          
                      }else
                          
                      if newRecoId == "client_number_5" {
                            
                        nameOfIcon = "eye"
                            
                      }else
                            
                      if newRecoId == "client_number_7" {
                              
                        nameOfIcon = "number"
                              
                      }else
                              
                      if newRecoId == "client_time" {
                                
                        nameOfIcon = "time"
                                
                      }else
                        
                      if newRecoId == "client_more_time" {
                          
                        nameOfIcon = "more_time"
                          
                      }else
                          
                      if newRecoId == "client_property" {
                            
                        nameOfIcon = "property"
                            
                      }else
                            
                      if newRecoId == "client_deliverable_25" {
                              
                        nameOfIcon = "deliverable"
                              
                      }else
                      
                      if newRecoId == "client_deliverable_50" {
                          
                        nameOfIcon = "deliverable"
                          
                      }else
                        
                      if newRecoId == "client_deliverable_75" {
                          
                        nameOfIcon = "deliverable"
                          
                      }else
                          
                      if newRecoId == "client_deliverable_100" {
                            
                        nameOfIcon = "deliverable"
                            
                      }
                    
                    }
                    
                    let newRecommendation = RecommendationModelData.init(newBody: newBody,
                      newRecoId: newRecoId)
                    newRecommendation.iconName = nameOfIcon
                    
                    arrayOfRecommendations.append(newRecommendation)
                    
                  }
                  
                  let newPitchEvaluationForCompany = PitchEvaluationByUserModelDataForCompany.init(newBrandName: newBrandName,
                    newBreakDown: newBreakDown,
                    newBriefDate: newBriefDate,
                    newBriefEmailContact: newBriefEmailContact,
                    newCompanyName: newCompanyName,
                    newPitchId: newPitchID,
                    newPitchName: newPitchName,
                    newPitchTypesPercentage: newPitchesTypesPercentage,
                    newWinner: newWinner)
                  newPitchEvaluationForCompany.recommendations = arrayOfRecommendations
                  
                  newArrayOfPitchesByUserForCompany.append(newPitchEvaluationForCompany)
            
                }
                
                actionsToMakeAfterFinished(pitchEvaluationsByUser: nil, pitchesForCompany: newArrayOfPitchesByUserForCompany)
                
                
                  print(json)
                
                
                
                
                
                
                
                
                
                
                
                
              }
            

          
          }
          
        } else {
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR")
//          actionsToMakeAfterFinished()
        }
    }
  }
  
  func requestToCreateCompany(nameOfTheNewCompany: String!, actionsToMakeAfterSuccesfullCreateNewCompany: (newCompanyCreated: CompanyModelData)-> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/companies"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    var values: [String:AnyObject]
    
    let companyDictionary = ["name" : nameOfTheNewCompany]
    
    if UserSession.session.auth_token != nil {
      
      values = [
        "auth_token": UserSession.session.auth_token,
        "company": companyDictionary
      ]
      
    } else {
      
      values = ["id": "bla"]//Supposedly never happend
      
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let newCompanyName = (json["name"] as? String != nil ? json["name"] as! String : "New Company")
          let newCompanyId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          let brands = [BrandModelData]()
          
          let newCompany = CompanyModelData(newId: newCompanyId,
                                          newName: newCompanyName,
                                        newBrands: brands)
          
          actionsToMakeAfterSuccesfullCreateNewCompany(newCompanyCreated: newCompany)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  
  func requestToCreateBrand(companyData: CompanyModelData, nameOfTheNewBrand: String!, actionsToMakeAfterSuccesfullCreateNewBrand: (newBrandCreated: BrandModelData)-> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/brands"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    var values: [String:AnyObject]
    
    let brandDictionary = ["name" : nameOfTheNewBrand,
                           "company_id" : companyData.id
                           ]
    
    if UserSession.session.auth_token != nil {
      
      values = [
        "auth_token": UserSession.session.auth_token,
        "brand": brandDictionary
      ]
      
    } else {
      
      values = ["id": "bla"]//Supposedly never happend
      
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let newBrandId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          let newBrandName = (json["name"] as? String != nil ? String(json["name"] as! String) : "New Brand")
          
          let newBrand = BrandModelData.init(newId: newBrandId,
                                           newName: newBrandName,
                                    newContactName: nil,
                                   newContactEMail: nil,
                                newContactPosition: nil,
                             newProprietaryCompany: nil)
          
          

          actionsToMakeAfterSuccesfullCreateNewBrand(newBrandCreated: newBrand)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToCreateProjectPitch(pitchData: ProjectPitchModelData!, actionsToMakeAfterSuccesfullCreateNewPitch: (newPitchCreated: ProjectPitchModelData)-> Void) {
    
//    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitches"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    var skill_categories = [String!]()
    
    for category in pitchData.arrayOfPitchCategories {
      
      skill_categories.append(category.pitchSkillCategoryId!)
      
    }
    
    var values: [String:AnyObject]
    
    let pitchDictionary = ["name" : pitchData.name,
                           "brand_id" : pitchData.brandId,
                           "brief_email_contact" : pitchData.briefEMailContact,
                           "brief_date" : pitchData.briefDate
                           ]
    
    if UserSession.session.auth_token != nil {
      
      values = [
        "auth_token": UserSession.session.auth_token,
        "skill_categories": skill_categories,
        "pitch" : pitchDictionary
      ]
      
    } else {
      
      values = ["id": "bla"]//Supposedly never happend
      
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        print()
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
//          let newCompanyName = (json["name"] as? String != nil ? json["name"] as! String : "New Company")
//          let newCompanyId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
//          let brands = [BrandModelData]()
          
//          let newCompany = CompanyModelData(newId: newCompanyId,
//            newName: newCompanyName,
//            newBrands: brands)
          
          let projectPitchId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          let projectPitchName = (json["name"] as? String != nil ? json["name"] as! String : "New Pitch")
          let projectBriefDate = (json["brief_date"] as? String != nil ? json["brief_date"] as! String : "01/01/1900")
          let projectPitchBriefEMailContact = (json["brief_email_contact"] as? String != nil ? json["brief_email_contact"] as! String : "briefContact@contact.com")
          
          let arrayOfPitchEvaluation = (json["pitch_evaluations"] as? Array<[String: AnyObject]> != nil ? json["pitch_evaluations"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
          
          var newVoidPitchEvaluationID = ""
          
          if arrayOfPitchEvaluation.count > 0 {
          
            let firstPitchEvaluation = arrayOfPitchEvaluation.first!
            newVoidPitchEvaluationID = (firstPitchEvaluation["id"] as? Int != nil ? String(firstPitchEvaluation["id"] as! Int) : "")
          
          }
          
          var arrayOfCategories = [PitchSkillCategory]()
          
          let categories = json["skill_categories"] as? Array<[String:AnyObject]>
          
          if categories != nil {
            
            for category in categories! {
              
              var categoryId:String!
              if category["id"] as? Int != nil {
                categoryId = String(category["id"] as! Int)
              }
              let categoryName = category["name"] as! String
              
              let newProjectPitchSkillCategory = PitchSkillCategory(newPitchSkillCategoryId: categoryId,
                newSkillCategoryName: categoryName,
                newIsThisCategory: true,
                newSkills: [Skill]())
              
              arrayOfCategories.append(newProjectPitchSkillCategory)
              
            }
            
          }
          
          let brandInfo = json["brand"] as? [String: AnyObject]
          
          var projectPitchBrandId = "-1"
          
          if brandInfo != nil {
          
            projectPitchBrandId = (brandInfo!["id"] as? Int != nil ? String(brandInfo!["id"] as! Int) : "-1")
          
          }
          
          let newProjectPitchCreated = ProjectPitchModelData(newId: projectPitchId, newName: projectPitchName,
            newBrandId: projectPitchBrandId,
            newBriefDate: projectBriefDate,
            newBrieEMailContact: projectPitchBriefEMailContact,
            newArrayOfPitchCategories: arrayOfCategories)
          
          newProjectPitchCreated.voidPitchEvaluationId = newVoidPitchEvaluationID
          
          actionsToMakeAfterSuccesfullCreateNewPitch(newPitchCreated: newProjectPitchCreated)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToCreateAVoidEvaluationOfProjectPitch(params: [String: AnyObject], actionsToMakeAfterSuccessfullyCreateAVoidPitchEvaluation: (newIdOfVoidPitchEvaluation: String) -> Void, actionsToMakeWhenPitchEvaluationAlreadyCreated: (errorMessage: String) -> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        print()
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let idOfVoidPitchEvaluation = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          
          actionsToMakeAfterSuccessfullyCreateAVoidPitchEvaluation(newIdOfVoidPitchEvaluation:  idOfVoidPitchEvaluation)
          
          
        }else
          
          if response.response?.statusCode == 422 {
            
            let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
            
            print(json)
            
            let message = (json["errors"] as? String != nil ? json["errors"] as! String : "")
            
            if message == "Ya existe una evaluación del pitch para este usuario." {
              
              actionsToMakeWhenPitchEvaluationAlreadyCreated(errorMessage: message)
              
            }
            
          } else {
            
            UtilityManager.sharedInstance.hideLoader()
            
            print("ERROR")
            
        }
    }
    
    
  }
  
  
  func requestToCreateEvaluationOfProjectPitch(params: [String: AnyObject], actionsToMakeAfterSuccesfullCreateNewEvaluationPitch: (newEvaluationPitchCreated: PitchEvaluationModelData)-> Void, actionsToMakeWhenPitchEvaluationAlreadyCreated: (errorMessage: String) -> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        print()
        if response.response?.statusCode == 201 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let newActivityStatus = (json["activity_status"] as? Int != nil ? String(json["activity_status"] as! Int) : "")
          
          var newAreDeliverablesClearBool: Bool
          let newAreDeliverablesClear = (json["are_deliverables_clear"] as? Int != nil ? json["are_deliverables_clear"] as! Int : -1)
          if newAreDeliverablesClear == 1 {
            newAreDeliverablesClearBool = true
          }else{
            newAreDeliverablesClearBool = false
          }
          
          var newAreObjectivesClearBool: Bool
          let newAreObjectivesClear = (json["are_objectives_clear"] as? Int != nil ? json["are_objectives_clear"] as! Int : -1)
          if newAreObjectivesClear == 1 {
            newAreObjectivesClearBool = true
          }else{
            newAreObjectivesClearBool = false
          }
          
          var newEvaluationStatusBool: Bool
          let newEvaluationStatus = (json["evaluation_status"] as? Int != nil ? json["evaluation_status"] as! Int : -1)
          if newEvaluationStatus == 1 {
            newEvaluationStatusBool = true
          }else{
            newEvaluationStatusBool = false
          }
          
          var newHasSelectionCriteriaBool: Bool
          let newHasSelectionCriteriaInt = (json["has_selection_criteria"] as? Int != nil ? json["has_selection_criteria"] as! Int : -1)
          if newHasSelectionCriteriaInt == 1 {
            newHasSelectionCriteriaBool = true
          }else{
            newHasSelectionCriteriaBool = false
          }
          
          let newId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "")
          
          var newIsBudgetKnownBool: Bool
          let newIsBudgetKnown = (json["is_budget_known"] as? Int != nil ? json["is_budget_known"] as! Int : -1)
          if newIsBudgetKnown == 1 {
            newIsBudgetKnownBool = true
          }else{
            newIsBudgetKnownBool = false
          }
          
          let newNumberOfAgencies = (json["number_of_agencies"] as? String != nil ? json["number_of_agencies"] as! String : "")
          let newNumberOfRounds = (json["number_of_rounds"] as? String != nil ? json["number_of_rounds"] as! String : "")
          let newPitchId = (json["pitch_id"] as? Int != nil ? String(json["pitch_id"] as! Int) : "")
          let newPitchStatus = (json["pitch_status"] as? Int != nil ? String(json["pitch_status"] as! Int) : "")
          let newScore = (json["score"] as? Int != nil ? String(json["score"] as! Int) : "")
          let newTimeToKnowDecision = (json["time_to_know_decision"] as? String != nil ? json["time_to_know_decision"] as! String : "")
          let newTimeToPresent = (json["time_to_present"] as? String != nil ? json["time_to_present"] as! String: "")
          let newUserId = (json["user_id"] as? Int != nil ? String(json["user_id"] as! Int) : "")
                    
          var newWasWonBool: Bool
          let newWasWonInt = (json["was_won"] as? Int != nil ? json["was_won"] as! Int : -1)
          if newWasWonInt == 1 {
            newWasWonBool = true
          }else{
            newWasWonBool = false
          }
          
          //Do sé
          var newDeliverCopyrightForPitching: String = ""
          if json["deliver_copyright_for_pitching"] as? Int != nil {
            
            newDeliverCopyrightForPitching = String(json["deliver_copyright_for_pitching"] as! Int)
            
          }else
            if json["deliver_copyright_for_pitching"] as? String != nil {
        
              newDeliverCopyrightForPitching = json["deliver_copyright_for_pitching"] as! String
              
            }
          
          var newIsMarketingInvolved: String = ""
          if json["is_marketing_involved"] as? Int != nil {
            
            newIsMarketingInvolved = String(json["is_marketing_involved"] as! Int)
            
          }else
            if json["is_marketing_involved"] as? String != nil {
            
              newIsMarketingInvolved = json["is_marketing_involved"] as! String
              
            }
          
          let newEvaluationOfPitchCreated = PitchEvaluationModelData.init(
            newId: newId,
            newPitchId: newPitchId,
            newUserId: newUserId,
            newEvaluationStatus: newEvaluationStatusBool,
            newPitchStatus: newPitchStatus,
            newAreObjectivesClear: newAreObjectivesClearBool,
            newTimeToPresent: newTimeToPresent,
            newIsBudgetKnown: newIsBudgetKnownBool,
            newNumberOfAgencies: newNumberOfAgencies,
            newAreDeliverablesClear: newAreDeliverablesClearBool,
            newIsMarketingInvolved: newIsMarketingInvolved,
            newTimeToKnowDecision: newTimeToKnowDecision,
            newScore: newScore,
            newActivityStatus: newActivityStatus,
            newWasWon: newWasWonBool,
            newNumberOfRounds: newNumberOfRounds,
            newDeliverCopyrightForPitching: newDeliverCopyrightForPitching,
            newHasSelectionCriteria: newHasSelectionCriteriaBool)
          
          actionsToMakeAfterSuccesfullCreateNewEvaluationPitch(newEvaluationPitchCreated: newEvaluationOfPitchCreated)

      
          //actionsToMakeAfterSuccesfullCreateNewEvaluationPitch(newPitchCreated: newProjectPitchCreated)
          
        }else
        
          if response.response?.statusCode == 422 {
            
            let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
            
            print(json)
            
            let message = (json["errors"] as? String != nil ? json["errors"] as! String : "")
            
            if message == "Ya existe una evaluación del pitch para este usuario." {
              
              actionsToMakeWhenPitchEvaluationAlreadyCreated(errorMessage: message)
              
            }
            
        } else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToGetPitchEvaluationByPitchID(idOfPitchEvaluation: String, actionsToMakeAfterGetSuccesfullyPitchEvaluation: (evaluationData: [String: AnyObject]) -> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/" + idOfPitchEvaluation
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let pitchEvaluationData = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          actionsToMakeAfterGetSuccesfullyPitchEvaluation(evaluationData: pitchEvaluationData as! [String : AnyObject])
          
        } else {
          
          print("ERROR WHEN GET PITCH EVALUATION \(response)")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
    
    
  }

  func requestToUpdateEvaluationOfProjectPitch(params: [String: AnyObject], actionsToMakeAfterSuccesfullUpdateNewEvaluationPitch: (newEvaluationPitchCreated: PitchEvaluationModelData)-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/update"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        print()
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let newActivityStatus = (json["activity_status"] as? Int != nil ? String(json["activity_status"] as! Int) : "")
          
          var newAreDeliverablesClearBool: Bool
          let newAreDeliverablesClear = (json["are_deliverables_clear"] as? Int != nil ? json["are_deliverables_clear"] as! Int : -1)
          if newAreDeliverablesClear == 1 {
            newAreDeliverablesClearBool = true
          }else{
            newAreDeliverablesClearBool = false
          }
          
          var newAreObjectivesClearBool: Bool
          let newAreObjectivesClear = (json["are_objectives_clear"] as? Int != nil ? json["are_objectives_clear"] as! Int : -1)
          if newAreObjectivesClear == 1 {
            newAreObjectivesClearBool = true
          }else{
            newAreObjectivesClearBool = false
          }
          
          var newEvaluationStatusBool: Bool
          let newEvaluationStatus = (json["evaluation_status"] as? Int != nil ? json["evaluation_status"] as! Int : -1)
          if newEvaluationStatus == 1 {
            newEvaluationStatusBool = true
          }else{
            newEvaluationStatusBool = false
          }
          
          var newHasSelectionCriteriaBool: Bool
          let newHasSelectionCriteriaInt = (json["has_selection_criteria"] as? Int != nil ? json["has_selection_criteria"] as! Int : -1)
          if newHasSelectionCriteriaInt == 1 {
            newHasSelectionCriteriaBool = true
          }else{
            newHasSelectionCriteriaBool = false
          }
          
          let newId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "")
          
          var newIsBudgetKnownBool: Bool
          let newIsBudgetKnown = (json["is_budget_known"] as? Int != nil ? json["is_budget_known"] as! Int : -1)
          if newIsBudgetKnown == 1 {
            newIsBudgetKnownBool = true
          }else{
            newIsBudgetKnownBool = false
          }
          
          let newNumberOfAgencies = (json["number_of_agencies"] as? String != nil ? json["number_of_agencies"] as! String : "")
          let newNumberOfRounds = (json["number_of_rounds"] as? String != nil ? json["number_of_rounds"] as! String : "")
          let newPitchId = (json["pitch_id"] as? Int != nil ? String(json["pitch_id"] as! Int) : "")
          let newPitchStatus = (json["pitch_status"] as? Int != nil ? String(json["pitch_status"] as! Int) : "")
          let newScore = (json["score"] as? Int != nil ? String(json["score"] as! Int) : "")
          let newTimeToKnowDecision = (json["time_to_know_decision"] as? String != nil ? json["time_to_know_decision"] as! String : "")
          let newTimeToPresent = (json["time_to_present"] as? String != nil ? json["time_to_present"] as! String: "")
          let newUserId = (json["user_id"] as? Int != nil ? String(json["user_id"] as! Int) : "")
          
          var newWasWonBool: Bool
          let newWasWonInt = (json["was_won"] as? Int != nil ? json["was_won"] as! Int : -1)
          if newWasWonInt == 1 {
            newWasWonBool = true
          }else{
            newWasWonBool = false
          }
          
          //Do sé
          var newDeliverCopyrightForPitching: String = ""
          if json["deliver_copyright_for_pitching"] as? Int != nil {
            
            newDeliverCopyrightForPitching = String(json["deliver_copyright_for_pitching"] as! Int)
            
          }else
            if json["deliver_copyright_for_pitching"] as? String != nil {
              
              newDeliverCopyrightForPitching = json["deliver_copyright_for_pitching"] as! String
              
          }
          
          var newIsMarketingInvolved: String = ""
          if json["is_marketing_involved"] as? Int != nil {
            
            newIsMarketingInvolved = String(json["is_marketing_involved"] as! Int)
            
          }else
            if json["is_marketing_involved"] as? String != nil {
              
              newIsMarketingInvolved = json["is_marketing_involved"] as! String
              
          }
          
          let newEvaluationOfPitchCreated = PitchEvaluationModelData.init(
            newId: newId,
            newPitchId: newPitchId,
            newUserId: newUserId,
            newEvaluationStatus: newEvaluationStatusBool,
            newPitchStatus: newPitchStatus,
            newAreObjectivesClear: newAreObjectivesClearBool,
            newTimeToPresent: newTimeToPresent,
            newIsBudgetKnown: newIsBudgetKnownBool,
            newNumberOfAgencies: newNumberOfAgencies,
            newAreDeliverablesClear: newAreDeliverablesClearBool,
            newIsMarketingInvolved: newIsMarketingInvolved,
            newTimeToKnowDecision: newTimeToKnowDecision,
            newScore: newScore,
            newActivityStatus: newActivityStatus,
            newWasWon: newWasWonBool,
            newNumberOfRounds: newNumberOfRounds,
            newDeliverCopyrightForPitching: newDeliverCopyrightForPitching,
            newHasSelectionCriteria: newHasSelectionCriteriaBool)
          
          actionsToMakeAfterSuccesfullUpdateNewEvaluationPitch(newEvaluationPitchCreated: newEvaluationOfPitchCreated)
          
          
          //actionsToMakeAfterSuccesfullCreateNewEvaluationPitch(newPitchCreated: newProjectPitchCreated)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToCancelPitchEvaluation(params: [String: AnyObject], actionsToMakeAfterSuccesfullCancelPitchEvaluation: (pitchEvaluationCancelled: AnyObject)-> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/cancel"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          actionsToMakeAfterSuccesfullCancelPitchEvaluation(pitchEvaluationCancelled: json)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToDeclinePitchEvaluation(params: [String: AnyObject], actionsToMakeAfterSuccesfullyDeclinedPitchEvaluation: (pitchEvaluationDeclined: AnyObject)-> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/decline"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          actionsToMakeAfterSuccesfullyDeclinedPitchEvaluation(pitchEvaluationDeclined: json)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  
  func requestToArchivePitchEvaluation(params: [String: AnyObject], actionsToMakeAfterSuccesfullyArchivedPitchEvaluation: (pitchEvaluationArchived: AnyObject)-> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/archive"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          actionsToMakeAfterSuccesfullyArchivedPitchEvaluation(pitchEvaluationArchived: json)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToDestroyPitchEvaluation(params: [String: AnyObject], actionsToMakeAfterSuccesfullyDestroyedPitchEvaluation: ()-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/destroy"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 204 {
          
          actionsToMakeAfterSuccesfullyDestroyedPitchEvaluation()
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToSaveAddResults(params: [String: AnyObject], actionsToMakeAfterSuccesfullyAddResults: ()-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_results"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          actionsToMakeAfterSuccesfullyAddResults()
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToSavePitchSurvey(params: [String: AnyObject], actionsToMakeAfterSuccesfullyPitchSurveySaved: ()-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_winner_surveys"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 201 {
          
          actionsToMakeAfterSuccesfullyPitchSurveySaved()
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToUpdatePitchResults(params: [String: AnyObject], actionsToMakeAfterSuccesfullyPitchResultsSaved: ()-> Void) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_results/update"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          actionsToMakeAfterSuccesfullyPitchResultsSaved()
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
          print("ERROR")
          
        }
    }
  }
  
  func requestToGetPitchResults(pitchId: String, functionToMakeWhenThereIsPitchResultCreated: (pitchResult: PitchResultsModelData) -> Void, functionToMakeWhenThereIsNotPitchResultCreated: () -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_results/" + pitchId
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "GET"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let newId = (json["id"] as? Int != nil ? String(json["id"] as! Int) : "-1")
          let newAgencyId = (json["agency_id"] as? Int != nil ? String(json["agency_id"] as! Int) : "")
          let newPitchId = (json["pitch_id"] as? Int != nil ? String(json["pitch_id"] as! Int) : "")
          
          var newGotFeedBack: Bool! = nil
          let newGotFeedbackInt = (json["got_feedback"] as? Int != nil ? json["got_feedback"] as! Int : -1)
          if newGotFeedbackInt == 1 {
            newGotFeedBack = true
          }else
            if newGotFeedbackInt == 0{
              newGotFeedBack = false
            }
          
          var newGotResponse: Bool! = nil
          let newGotResponseInt = (json["got_response"] as? Int != nil ? json["got_response"] as! Int : -1)
          if newGotResponseInt == 1 {
            newGotResponse = true
          }else
            if newGotResponseInt == 0{
              newGotResponse = false
            }
          
          var newHasSomeoneElseWon: Bool! = nil
          let newHasSomeoneElseWonInt = (json["has_someone_else_won"] as? Int != nil ? json["has_someone_else_won"] as! Int : -1)
          if newHasSomeoneElseWonInt == 1 {
            newHasSomeoneElseWon = true
          }else
            if newHasSomeoneElseWonInt == 0{
              newHasSomeoneElseWon = false
            }
          
          var newWasPitchWon: Bool! = nil
          let newWasPitchWonInt = (json["was_pitch_won"] as? Int != nil ? json["was_pitch_won"] as! Int : -1)
          if newWasPitchWonInt == 1 {
            newWasPitchWon = true
          }else
            if newWasPitchWonInt == 0 {
              newWasPitchWon = false
            }
          
          var newWasProposalPresented: Bool! = nil
          let newWasProposalPresentedInt = (json["was_proposal_presented"] as? Int != nil ? json["was_proposal_presented"] as! Int : -1)
          if newWasProposalPresentedInt == 1 {
            newWasProposalPresented = true
          }else
            if newWasProposalPresentedInt == 0{
              newWasProposalPresented = false
            }
          
          let newWhenAreYouPresenting = (json["when_are_you_presenting"] as? String != nil ? json["when_are_you_presenting"] as! String : "")
          let newWhenWillYouGetResponse = (json["when_will_you_get_response"] as? String != nil ? json["when_will_you_get_response"] as! String : "")
          
          
          let newPitchResult = PitchResultsModelData.init(newPitchResultsId: newId,
            newAgencyId: newAgencyId,
            newGotFeedback: newGotFeedBack,
            newGotResponse: newGotResponse,
            newHasSomeoneElseWon: newHasSomeoneElseWon,
            newPitchId: newPitchId,
            newWasPitchWon: newWasPitchWon,
            newWasProposalPresented: newWasProposalPresented,
            newWhenAreYouPresenting: newWhenAreYouPresenting,
            newWhenWillYouGetResponse: newWhenWillYouGetResponse)
          
          
          functionToMakeWhenThereIsPitchResultCreated(pitchResult: newPitchResult)
          
        } else {
          
          functionToMakeWhenThereIsNotPitchResultCreated()
          
          print("ERROR \(response)")
          UtilityManager.sharedInstance.hideLoader()
          
        }
    }
  }
  
  
  func requestToFilterPitchEvaluations(params: [String: AnyObject], actionsToMakeWhenReceiveElements:(arrayFiltered: [PitchEvaluationByUserModelData]) -> Void ) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/filter"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
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
        print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          let arrayOfPitchEvaluationByUserModelData = json as? Array<[String: AnyObject]>
          
          if arrayOfPitchEvaluationByUserModelData != nil {
            
            var newArrayOfPitchesByUser = [PitchEvaluationByUserModelData]()
            
            for pitchEvaluationByUser in arrayOfPitchEvaluationByUserModelData! {
              
              let newPitchEvaluationId = (pitchEvaluationByUser["pitch_evaluation_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_evaluation_id"] as! Int) : "-1")
              let newPitchId = (pitchEvaluationByUser["pitch_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_id"] as! Int) : "-1")
              let newPitchName = (pitchEvaluationByUser["pitch_name"] as? String != nil ? pitchEvaluationByUser["pitch_name"] as! String : "No Pitch Name")
              let newBriefDate = (pitchEvaluationByUser["brief_date"] as? String != nil ? pitchEvaluationByUser["brief_date"] as! String : "01/01/1900")
              let newScore = (pitchEvaluationByUser["score"] as? Int != nil ? pitchEvaluationByUser["score"] as! Int : -1)
              let newBrandName = (pitchEvaluationByUser["brand"] as? String != nil ? pitchEvaluationByUser["brand"] as! String : "No Brand Name")
              let newCompanyName = (pitchEvaluationByUser["company"] as? String != nil ? pitchEvaluationByUser["company"] as! String : "No Company Name")
              let newOtherScores = (pitchEvaluationByUser["other_scores"] as? [Int] != nil ? pitchEvaluationByUser["other_scores"] as! [Int] : [Int]())
              var newWasWon: Bool! = nil
              newWasWon = (pitchEvaluationByUser["was_won"] as? Bool != nil ? pitchEvaluationByUser["was_won"] as! Bool : nil)
              let newPitchStatus = (pitchEvaluationByUser["pitch_status"] as? Int != nil ? pitchEvaluationByUser["pitch_status"] as! Int : 4) //4 is for archived, i'll ask this to client in future
              let newPitchEvaluationStatus = (pitchEvaluationByUser["evaluation_status"] as? Bool != nil ? pitchEvaluationByUser["evaluation_status"] as! Bool : false)
              let newHasResults = (pitchEvaluationByUser["has_results"] as? Bool != nil ? pitchEvaluationByUser["has_results"] as! Bool : false)
              let newHasPitchWinnerSurvey = (pitchEvaluationByUser["has_pitch_winner_survey"] as? Bool != nil ? pitchEvaluationByUser["has_pitch_winner_survey"] as! Bool : false)
              let newPitchsResultsId = (pitchEvaluationByUser["pitch_results_id"] as? Int != nil ? String(pitchEvaluationByUser["pitch_results_id"] as! Int) : "-1")
              
              
              
              let arrayOfEvaluationPitchSkillCategories = (pitchEvaluationByUser["skill_categories"] as? Array<[String: AnyObject]> != nil ? pitchEvaluationByUser["skill_categories"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
              
              var newArrayOfEvaluationSkillCategoryModelData = [EvaluationPitchSkillCategoryModelData]()
              
              if arrayOfEvaluationPitchSkillCategories.count > 0 {
                
                for evaluationSkillCategory in arrayOfEvaluationPitchSkillCategories {
                  
                  let newEvaluationPitchSkillCategoryID = (evaluationSkillCategory["id"] as? Int != nil ? String(evaluationSkillCategory["id"] as! Int) : "-1")
                  let newEvaluationPitchSkillCategoryName = (evaluationSkillCategory["name"] as? String != nil ? evaluationSkillCategory["name"] as! String : "Skill Category NO NAME")
                  
                  let newEvaluationPitchSkillCategory = EvaluationPitchSkillCategoryModelData.init(newEvaluationSkillCategoryId: newEvaluationPitchSkillCategoryID,
                    newEvaluationSkillCategoryName: newEvaluationPitchSkillCategoryName)
                  
                  newArrayOfEvaluationSkillCategoryModelData.append(newEvaluationPitchSkillCategory)
                  
                }
                
              }
              
              let newPitchEvaluationByUser = PitchEvaluationByUserModelData.init(
                newPitchEvaluationId: newPitchEvaluationId,
                newPitchId: newPitchId,
                newPitchName: newPitchName,
                newBriefDate: newBriefDate,
                newScore: newScore,
                newBrandName: newBrandName,
                newCompanyName: newCompanyName,
                newOtherScores: newOtherScores,
                newArrayOfEvaluationPitchSkillCategory: newArrayOfEvaluationSkillCategoryModelData,
                newWasWon: newWasWon,
                newPitchStatus: newPitchStatus,
                newEvaluationStatus: newPitchEvaluationStatus,
                newHasResults: newHasResults,
                newHasPitchWinnerSurvey: newHasPitchWinnerSurvey,
                newPitchResultsId: newPitchsResultsId)
              
              newArrayOfPitchesByUser.append(newPitchEvaluationByUser)
              
            }
            
            actionsToMakeWhenReceiveElements(arrayFiltered: newArrayOfPitchesByUser)
            
          }
          
        } else {
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR")
          //          actionsToMakeAfterFinished()
        }
    }
    
  }
  
  func requestToGetPitchEvaluationsAveragePerMonthByAgency(extraParams: [String: AnyObject]?,actionsToMakeAfterGetingInfo: (arrayOfScoresPerMonthOfAgency:[PitchEvaluationAveragePerMonthModelData] , arrayOfUsers: [AgencyUserModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/average_per_month_by_agency"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    //print(caseData)
    
    var params = ["id" : AgencyModel.Data.id,
                  "auth_token" : UserSession.session.auth_token
                  ]
    
    if extraParams != nil {
      
      params["start_date"] = (extraParams!["start_date"] as? String != nil ? extraParams!["start_date"] as! String : "2016-1-1")
      params["end_date"] = (extraParams!["end_date"] as? String != nil ? extraParams!["end_date"] as! String : "2017-1-1")
      
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          let arrayOfUsers = json["users"] as? Array<[String: AnyObject]>
          let arrayOfScores = json["average_per_month"] as? Array<[String: AnyObject]>
          
          var arrayOfUsersModelData = [AgencyUserModelData]()
          
          if arrayOfUsers != nil {
            
            for user in arrayOfUsers! {
              
              let newId = (user["id"] as? Int != nil ? String(user["id"] as! Int) : "-1")
              let newFirstName = (user["first_name"] as? String != nil ? user["first_name"] as! String : "")
              let newLastName = (user["last_name"] as? String != nil ? user["last_name"] as! String : "")
              let newMail = (user["email"] as? String != nil ? user["email"] as! String : "")
              
              let newUser = AgencyUserModelData.init(newId: newId,
                newFirstName: newFirstName,
                newLastName: newLastName)
              newUser.email = newMail
              
              arrayOfUsersModelData.append(newUser)
              
            }
            
          }
          
          
          var arrayOfScoresModelData = [PitchEvaluationAveragePerMonthModelData]()
          
          if arrayOfScores != nil {
            
            for score in arrayOfScores! {
              
              let newId: String? = (score["id"] as? Int != nil ? String(score["id"] as! Int) : nil)
              let newMonthYear = (score["month_year"] as? String != nil ? score["month_year"] as! String : "")
              let newScore = (score["score"] as? Int != nil ? String(score["score"] as! Int) : "")
              
              let newScoreModelData = PitchEvaluationAveragePerMonthModelData.init(newId: newId,
                newMonthYear: newMonthYear,
                newScore: newScore)
              
              arrayOfScoresModelData.append(newScoreModelData)
              
            }
            
          }
          
          actionsToMakeAfterGetingInfo(arrayOfScoresPerMonthOfAgency: arrayOfScoresModelData, arrayOfUsers: arrayOfUsersModelData)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR DELETING CASE")
        }
        
    }
    
  }

  func requestToGetPitchEvaluationsAveragePerMonthByUser(params: [String: AnyObject],actionsToMakeAfterGetingInfo: (arrayOfScoresPerMonthByUser:[PitchEvaluationAveragePerMonthModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/average_per_month_by_user"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let arrayOfScores = json as? Array<[String: AnyObject]>
          
          var arrayOfScoresModelData = [PitchEvaluationAveragePerMonthModelData]()
          
          if arrayOfScores != nil {
            
            for score in arrayOfScores! {
              
              let newId: String? = (score["id"] as? Int != nil ? String(score["id"] as! Int) : nil)
              let newMonthYear = (score["month_year"] as? String != nil ? score["month_year"] as! String : "")
              let newScore = (score["score"] as? Int != nil ? String(score["score"] as! Int) : "")
              
              let newScoreModelData = PitchEvaluationAveragePerMonthModelData.init(newId: newId,
                newMonthYear: newMonthYear,
                newScore: newScore)
              
              arrayOfScoresModelData.append(newScoreModelData)
              
            }
            
          }
          
          actionsToMakeAfterGetingInfo(arrayOfScoresPerMonthByUser: arrayOfScoresModelData)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR GETTING AVERAGE BY USER")
        }
        
    }
    
  }
  
  func requestToGetPitchEvaluationsAveragePerMonthByBrand(params: [String: AnyObject],actionsToMakeAfterGetingInfo: (arrayOfScoresPerMonthByUser:[PitchEvaluationAveragePerMonthModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/average_per_month_by_brand"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let arrayOfScores = json as? Array<[String: AnyObject]>
          
          var arrayOfScoresModelData = [PitchEvaluationAveragePerMonthModelData]()
          
          if arrayOfScores != nil {
            
            for score in arrayOfScores! {
              
              let newId: String? = (score["id"] as? Int != nil ? String(score["id"] as! Int) : nil)
              let newMonthYear = (score["month_year"] as? String != nil ? score["month_year"] as! String : "")
              let newScore = (score["score"] as? Int != nil ? String(score["score"] as! Int) : "")
              
              let newScoreModelData = PitchEvaluationAveragePerMonthModelData.init(newId: newId,
                newMonthYear: newMonthYear,
                newScore: newScore)
              
              arrayOfScoresModelData.append(newScoreModelData)
              
            }
            
          }
          
          actionsToMakeAfterGetingInfo(arrayOfScoresPerMonthByUser: arrayOfScoresModelData)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR GETTING AVERAGE BY USER")
        }
        
    }
    
  }

  func requestToGetPitchEvaluationsAveragePerMonthByIndustry(extraParams: [String: AnyObject]?, actionsToMakeAfterGetingInfo: (arrayOfScoresPerMonthOfIndustry:[PitchEvaluationAveragePerMonthModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/average_per_month_industry"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    //print(caseData)
    
    var params = [
                  "auth_token" : UserSession.session.auth_token
                 ]
    
    if extraParams != nil {
      
      params["start_date"] = (extraParams!["start_date"] as? String != nil ? extraParams!["start_date"] as! String : "2016-1-1")
      params["end_date"] = (extraParams!["end_date"] as? String != nil ? extraParams!["end_date"] as! String : "2017-1-1")
      
    }
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let arrayOfScores = json as? Array<[String: AnyObject]>
          
          var arrayOfScoresModelData = [PitchEvaluationAveragePerMonthModelData]()
          
          if arrayOfScores != nil {
            
            for score in arrayOfScores! {
              
              let newId: String? = (score["id"] as? Int != nil ? String(score["id"] as! Int) : nil)
              let newMonthYear = (score["month_year"] as? String != nil ? score["month_year"] as! String : "")
              let newScore = (score["score"] as? Int != nil ? String(score["score"] as! Int) : "")
              
              let newScoreModelData = PitchEvaluationAveragePerMonthModelData.init(newId: newId,
                newMonthYear: newMonthYear,
                newScore: newScore)
              
              arrayOfScoresModelData.append(newScoreModelData)
              
            }
            
          }
          
          actionsToMakeAfterGetingInfo(arrayOfScoresPerMonthOfIndustry: arrayOfScoresModelData)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR DELETING CASE")
        }
        
    }
    
  }
  
  func requestToGetPitchEvaluationsDashboardSummaryByClient(actionsToMakeAfterGettingInfo:(numberOfPitchesByClientForDashboardSummary: [String: Int], arrayOfBrands: [BrandModelData], recommendations: [RecommendationModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/dashboard_summary_by_client"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    //print(caseData)
    
    let params = ["id" : MyCompanyModelData.Data.id,
                  "auth_token" : UserSession.session.auth_token
    ]
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          let numberOfHappitchesByClient = (json["happitch"] as? Int != nil ? json["happitch"] as! Int : 0)
          let numberOfHappiesByClient = (json["happy"] as? Int != nil ? json["happy"] as! Int : 0)
          let numberOfOksByClient = (json["ok"] as? Int != nil ? json ["ok"] as! Int : 0)
          let numberOfUnhappiesByClient = (json["unhappy"] as? Int != nil ? json["unhappy"] as! Int : 0)
          let numberOfLostPitchesByClient = (json["lost"] as? Int != nil ? json["lost"] as! Int : 0)
          let numberOfWonPitchesByClient = (json["won"] as? Int != nil ? json["won"] as! Int : 0)
          
          let finalNumberOfPitchesByClient = [
            "happitch": numberOfHappitchesByClient,
            "happy":    numberOfHappiesByClient,
            "ok":       numberOfOksByClient,
            "unhappy":  numberOfUnhappiesByClient,
            "lost":     numberOfLostPitchesByClient,
            "won":      numberOfWonPitchesByClient
          ]
          
          let arrayOfBrands = json["brands"] as? Array<[String: AnyObject]>
          var arrayOfBrandsModelData = [BrandModelData]()
          
          if arrayOfBrands != nil {
            
            for user in arrayOfBrands! {
              
              let newId = (user["id"] as? Int != nil ? String(user["id"] as! Int) : "-1")
              let newName = (user["name"] as? String != nil ? user["name"] as! String : "")

              
              let newUser = BrandModelData.init(newId: newId,
                newName: newName,
                newContactName: nil,
                newContactEMail: nil,
                newContactPosition: nil,
                newProprietaryCompany: nil)
              
              arrayOfBrandsModelData.append(newUser)
              
            }
            
          }
          
          var arrayOfRecommendations = [RecommendationModelData]()
          
          let recommendationsFromServer = (json["recommendations"] as? Array<[String: AnyObject]> != nil ? json["recommendations"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
          
          for recommendation in recommendationsFromServer {
            
            let newBody = (recommendation["body"] as? String != nil ? recommendation["body"] as! String : "")
            let newRecoId = (recommendation["reco_id"] as? String != nil ? recommendation["reco_id"] as! String : "")
            
            var nameOfIcon = ""
            if newRecoId != "" {
              
              if newRecoId == "client_objective_25" {
                
                nameOfIcon = "communication"
                
              }else
                
              if newRecoId == "client_objective_50" {
                  
                nameOfIcon = "communication"
                  
              }else
                  
              if newRecoId == "client_objective_75" {
                    
                nameOfIcon = "list"
                    
              }else
                    
              if newRecoId == "client_budget_25" {
                      
                nameOfIcon = "budget"
                      
              }else
                      
              if newRecoId == "client_budget_50" {
                        
                nameOfIcon = "budget"
                        
              }else
                        
              if newRecoId == "client_budget_75" {
                          
                nameOfIcon = "budget"
                          
              }else
                          
              if newRecoId == "client_budget_100" {
                            
                nameOfIcon = "budget"
                            
              }else
                            
              if newRecoId == "client_criteria" {
                              
                nameOfIcon = "criteria"
                              
              }else
                              
              if newRecoId == "client_number_5" {
                                
                nameOfIcon = "eye"
                                
              }else
                                
              if newRecoId == "client_number_7" {
                                  
                nameOfIcon = "number"
                                  
              }else
                                  
              if newRecoId == "client_time" {
                                    
                nameOfIcon = "time"
                                    
              }else
                                    
              if newRecoId == "client_more_time" {
                                      
                nameOfIcon = "more_time"
                                      
              }else
                                      
              if newRecoId == "client_property" {
                                        
                nameOfIcon = "property"
                                        
              }else
                                        
              if newRecoId == "client_deliverable_25" {
                                          
                nameOfIcon = "deliverable"
                                          
              }else
                                          
              if newRecoId == "client_deliverable_50" {
                                            
                nameOfIcon = "deliverable"
                                            
              }else
                                            
              if newRecoId == "client_deliverable_75" {
                
                nameOfIcon = "deliverable"
                                              
              }else
                                              
              if newRecoId == "client_deliverable_100" {
                                                
                nameOfIcon = "deliverable"
                                                
              }
              
            }
            
            let newRecommendation = RecommendationModelData.init(newBody: newBody,
              newRecoId: newRecoId)
            newRecommendation.iconName = nameOfIcon
            
            arrayOfRecommendations.append(newRecommendation)
            
          }

          actionsToMakeAfterGettingInfo(numberOfPitchesByClientForDashboardSummary: finalNumberOfPitchesByClient, arrayOfBrands: arrayOfBrandsModelData, recommendations: arrayOfRecommendations)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR GETTING")
        }
        
    }
    
  }
  
  
  func requestToGetPitchEvaluationsDashboardSummaryByBrand(params: [String: AnyObject], actionsToMakeAfterGettingInfoByBrand:(numberOfPitchesByBrandForDashboardSummary: [String: Int]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/dashboard_summary_by_brand"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let numberOfHappitchesByCompany = (json["happitch"] as? Int != nil ? json["happitch"] as! Int : 0)
          let numberOfHappiesByCompany = (json["happy"] as? Int != nil ? json["happy"] as! Int : 0)
          let numberOfOksByCompany = (json["ok"] as? Int != nil ? json ["ok"] as! Int : 0)
          let numberOfUnhappiesByCompany = (json["unhappy"] as? Int != nil ? json["unhappy"] as! Int : 0)
          let numberOfLostPitchesByCompany = (json["lost"] as? Int != nil ? json["lost"] as! Int : 0)
          let numberOfWonPitchesByCompany = (json["won"] as? Int != nil ? json["won"] as! Int : 0)
          
          let finalNumberOfPitchesByCompany = [
            "happitch": numberOfHappitchesByCompany,
            "happy":    numberOfHappiesByCompany,
            "ok":       numberOfOksByCompany,
            "unhappy":  numberOfUnhappiesByCompany,
            "lost":     numberOfLostPitchesByCompany,
            "won":      numberOfWonPitchesByCompany
          ]
          
          actionsToMakeAfterGettingInfoByBrand(numberOfPitchesByBrandForDashboardSummary: finalNumberOfPitchesByCompany)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR GETTING SUMMARY BY USER")
        }
        
    }
    
  }
  
  
  
  func requestToGetPitchEvaluationsDashboardSumaryByAgency(actionsToMakeAfterGetingInfo: (numberOfPitchesByAgencyForDashboardSumary: [String: Int] , arrayOfUsers: [AgencyUserModelData], recommendations: [RecommendationModelData]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/dashboard_summary_by_agency"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    //print(caseData)
    
    let params = ["id" : AgencyModel.Data.id,
                  "auth_token" : UserSession.session.auth_token
    ]
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          print(json)
          
          let numberOfHappitchesByAgency = (json["happitch"] as? Int != nil ? json["happitch"] as! Int : 0)
          let numberOfHappiesByAgency = (json["happy"] as? Int != nil ? json["happy"] as! Int : 0)
          let numberOfOksByAgency = (json["ok"] as? Int != nil ? json ["ok"] as! Int : 0)
          let numberOfUnhappiesByAgency = (json["unhappy"] as? Int != nil ? json["unhappy"] as! Int : 0)
          let numberOfLostPitchesByAgency = (json["lost"] as? Int != nil ? json["lost"] as! Int : 0)
          let numberOfWonPitchesByAgency = (json["won"] as? Int != nil ? json["won"] as! Int : 0)
          
          let finalNumberOfPitchesByAgency = [
            "happitch": numberOfHappitchesByAgency,
            "happy":    numberOfHappiesByAgency,
            "ok":       numberOfOksByAgency,
            "unhappy":  numberOfUnhappiesByAgency,
            "lost":     numberOfLostPitchesByAgency,
            "won":      numberOfWonPitchesByAgency
          ]
          
          let arrayOfUsers = json["users"] as? Array<[String: AnyObject]>
          var arrayOfUsersModelData = [AgencyUserModelData]()
          
          if arrayOfUsers != nil {
            
            for user in arrayOfUsers! {
              
              let newId = (user["id"] as? Int != nil ? String(user["id"] as! Int) : "-1")
              let newFirstName = (user["first_name"] as? String != nil ? user["first_name"] as! String : "")
              let newLastName = (user["last_name"] as? String != nil ? user["last_name"] as! String : "")
              let newMail = (user["email"] as? String != nil ? user["email"] as! String : "")
              
              let newUser = AgencyUserModelData.init(newId: newId,
                newFirstName: newFirstName,
                newLastName: newLastName)
              newUser.email = newMail
              
              arrayOfUsersModelData.append(newUser)
              
            }
            
          }
          
          var arrayOfRecommendations = [RecommendationModelData]()
          
          let recommendationsFromServer = (json["recommendations"] as? Array<[String: AnyObject]> != nil ? json["recommendations"] as! Array<[String: AnyObject]> : Array<[String: AnyObject]>())
          
          for recommendation in recommendationsFromServer {
            
            let newBody = (recommendation["body"] as? String != nil ? recommendation["body"] as! String : "")
            let newRecoId = (recommendation["reco_id"] as? String != nil ? recommendation["reco_id"] as! String : "")
            
            var nameOfIcon = ""
            if newRecoId != "" {
              
              if newRecoId == "agency_communication" {
                
                nameOfIcon = "communication"
                
              }else
                
              if newRecoId == "agency_list" {
                  
                nameOfIcon = "communication"
                  
              }else
                  
              if newRecoId == "agency_budget_1" {
                    
                nameOfIcon = "list"
                    
              }else
                    
              if newRecoId == "agency_budget_3" {
                      
                nameOfIcon = "budget"
                      
              }else
                      
              if newRecoId == "agency_sharing" {
                        
                nameOfIcon = "budget"
                        
              }else
                        
              if newRecoId == "agency_number_5" {
                          
                nameOfIcon = "budget"
                          
              }else
                          
              if newRecoId == "agency_number_7" {
                            
                nameOfIcon = "budget"
                            
              }else
                            
              if newRecoId == "agency_time" {
                              
                nameOfIcon = "criteria"
                              
              }else
                              
              if newRecoId == "agency_property" {
                                
                nameOfIcon = "eye"
                                
              }else
                                
              if newRecoId == "agency_deliverable" {
                                  
                nameOfIcon = "number"
                                  
              }else
                                  
              if newRecoId == "agency_careful" {
                                    
                nameOfIcon = "time"
                                    
              }else
                                    
              if newRecoId == "agency_speak" {
                                      
                nameOfIcon = "more_time"
                                      
              }else
                                      
              if newRecoId == "agency_alert" {
                                        
                nameOfIcon = "property"
                                        
              }
              
            }
            
            let newRecommendation = RecommendationModelData.init(newBody: newBody,
              newRecoId: newRecoId)
            newRecommendation.iconName = nameOfIcon
            
            arrayOfRecommendations.append(newRecommendation)
            
          }
          
          
          
          actionsToMakeAfterGetingInfo(numberOfPitchesByAgencyForDashboardSumary: finalNumberOfPitchesByAgency, arrayOfUsers: arrayOfUsersModelData, recommendations: arrayOfRecommendations)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR DELETING CASE")
        }
        
    }
    
  }
  
  func requestToGetPitchEvaluationsDashboardSummaryByUser(params: [String: AnyObject],actionsToMakeAfterGetingInfo: (numberOfPitchesByAgencyForDashboardSumary: [String: Int]) -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/pitch_evaluations/dashboard_summary_by_user"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let numberOfHappitchesByAgency = (json["happitch"] as? Int != nil ? json["happitch"] as! Int : 0)
          let numberOfHappiesByAgency = (json["happy"] as? Int != nil ? json["happy"] as! Int : 0)
          let numberOfOksByAgency = (json["ok"] as? Int != nil ? json ["ok"] as! Int : 0)
          let numberOfUnhappiesByAgency = (json["unhappy"] as? Int != nil ? json["unhappy"] as! Int : 0)
          let numberOfLostPitchesByAgency = (json["lost"] as? Int != nil ? json["lost"] as! Int : 0)
          let numberOfWonPitchesByAgency = (json["won"] as? Int != nil ? json["won"] as! Int : 0)
          
          let finalNumberOfPitchesByAgency = [
            "happitch": numberOfHappitchesByAgency,
            "happy":    numberOfHappiesByAgency,
            "ok":       numberOfOksByAgency,
            "unhappy":  numberOfUnhappiesByAgency,
            "lost":     numberOfLostPitchesByAgency,
            "won":      numberOfWonPitchesByAgency
          ]
          
          actionsToMakeAfterGetingInfo(numberOfPitchesByAgencyForDashboardSumary: finalNumberOfPitchesByAgency)
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR GETTING SUMMARY BY USER")
        }
        
    }
    
  }
  
  func requestToSetAgencyToFavorite(params: [String: AnyObject],actionsToMakeAfterSetAgencyToFavorite: () -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/companies/add_favorite_agency"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 201 {
          
          //let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          
          actionsToMakeAfterSetAgencyToFavorite()
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR SET TO FAVORITE")
        }
        
    }
    
  }
  
  func requestToRemoveAgencyFromFavorite(params: [String: AnyObject],actionsToMakeAfterRemoveAgencyFromFavorite: () -> Void) {
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/companies/remove_favorite_agency"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<400)
      .responseJSON{ response in
        
        //print(response)
        
        if response.response?.statusCode == 200 {
          
          //let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          
          actionsToMakeAfterRemoveAgencyFromFavorite()
          
        }else{
          
          UtilityManager.sharedInstance.hideLoader()
          print("ERROR REMOVING FAVORITE")
        }
        
    }
    
  }
  
  func requestToSearchCompanyPitch(params: [String: AnyObject], functionToMakeAfterSearching: (allPitches: [PitchEvaluationByUserModelDataForCompany]) -> Void) {
    
    //    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/pitch_evaluations/search"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          let arrayOfPitchForCompany = json as? Array<[String: AnyObject]>
          
          if arrayOfPitchForCompany != nil {
            
            var newArrayOfPitchesByUserForCompany = [PitchEvaluationByUserModelDataForCompany]()
            
            for pitchEvaluationForCompany in arrayOfPitchForCompany! {
              
              let newBrandName = (pitchEvaluationForCompany["brand"] as? String != nil ? pitchEvaluationForCompany["brand"] as! String : "No brand name")
              let newBriefDate = (pitchEvaluationForCompany["brief_date"] as? String != nil ? pitchEvaluationForCompany["brief_date"] as! String : "01/01/1900")
              let newBriefEmailContact = (pitchEvaluationForCompany["brief_email_contact"] as? String != nil ? pitchEvaluationForCompany["brief_email_contact"] as! String : "noBriefContact@mail.com")
              let newCompanyName = (pitchEvaluationForCompany["company"] as? String != nil ? pitchEvaluationForCompany["company"] as! String : "No company name")
              let newPitchID = (pitchEvaluationForCompany["pitch_id"] as? Int != nil ? String(pitchEvaluationForCompany["pitch_id"] as! Int) : "-1")
              let newPitchName = (pitchEvaluationForCompany["pitch_name"] as? String != nil ? pitchEvaluationForCompany["pitch_name"] as! String : "No Pitch Name")
              let newWinner = (pitchEvaluationForCompany["winner"] as? Int != nil ? String(pitchEvaluationForCompany["winner"] as! Int) : "-1")
              
              let newBreakDown = (pitchEvaluationForCompany["breakdown"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["breakdown"] as! [String: AnyObject] : [String: AnyObject]())
              
              let newPitchesTypesPercentage = (pitchEvaluationForCompany["pitch_types_percentage"] as? [String: AnyObject] != nil ? pitchEvaluationForCompany["pitch_types_percentage"] as! [String: AnyObject] : [String: AnyObject]())
              
              let newPitchEvaluationForCompany = PitchEvaluationByUserModelDataForCompany.init(newBrandName: newBrandName,
                newBreakDown: newBreakDown,
                newBriefDate: newBriefDate,
                newBriefEmailContact: newBriefEmailContact,
                newCompanyName: newCompanyName,
                newPitchId: newPitchID,
                newPitchName: newPitchName,
                newPitchTypesPercentage: newPitchesTypesPercentage,
                newWinner: newWinner)
              
              newArrayOfPitchesByUserForCompany.append(newPitchEvaluationForCompany)
              
            }
            
            print(newArrayOfPitchesByUserForCompany)
            
            functionToMakeAfterSearching(allPitches: newArrayOfPitchesByUserForCompany)
            
          }
          
        } else {
          
          print("ERROR")
          UtilityManager.sharedInstance.hideLoader()
          
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
          
            UtilityManager.sharedInstance.hideLoader()
          
            print("ERROR")
            
        }
    }
  }
  
}



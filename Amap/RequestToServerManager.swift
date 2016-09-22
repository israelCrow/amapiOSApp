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
          
          
          actionsToMakeAfterSuccesfullCreateNewPitch(newPitchCreated: newProjectPitchCreated)
          
        }else {
          
          UtilityManager.sharedInstance.hideLoader()
          
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
          
            UtilityManager.sharedInstance.hideLoader()
          
            print("ERROR")
            
        }
    }
  }
  
}



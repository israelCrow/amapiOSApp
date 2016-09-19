//
//  EditAgencyProfileViewController.swift
//  Amap
//
//  Created by Mac on 8/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

protocol EditAgencyProfileViewControllerDelegate {
  
  func requestToShowTabBarFromEditAgencyProfileViewControllerDelegate()
  
}

class EditAgencyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CasesViewDelegate, CreateCaseViewDelegate, ProfileViewDelegate {
    
  private let kEditAgencyProfile = "Editar Perfil Agencia"
  private let kNumberOfCardsInScrollViewMinusOne = 5
  
  private var flipCard: FlipCardView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  private var criteriaAgencyProfileEdit: CriteriaAgencyProfileEditView! = nil
  private var actualPage: Int! = 0
  private var saveChangesButton: UIButton! = nil
  private var leftButton: UIButton! = nil
  private var rightButton: UIButton! = nil
  private var lastFrameForFlipCard: CGRect! = nil
  private var isKeyboardAlreadyShown = false
  
  private var requestImageForCase: Bool = false
  private var requestImageForProfile: Bool = false
  
//  private var criteriaView: CriterionView! = nil
  private var participateView: ParticipateInView! = nil
//  private var exclusiveView: ExclusiveView! = nil
  private var createCaseView: CreateCaseView?
  private var casesView: CasesView! = nil
  private var skillsView: SkillsView! = nil
  private var profileView: ProfileView! = nil
  
  var delegate: EditAgencyProfileViewControllerDelegate?

  override func loadView() {
    
    self.editNavigationBar()
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    
  }
    
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
        
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton 
    
  }
  
  private func changeNavigationBarTitle() {
        
    let titleLabel = UILabel.init(frame: CGRectZero)
        
    let font = UIFont(name: "SFUIText-Regular",
                          size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
        
    let stringWithFormat = NSMutableAttributedString(
          string: kEditAgencyProfile,
          attributes:[NSFontAttributeName:font!,
          NSParagraphStyleAttributeName:style,
          NSForegroundColorAttributeName:color
        ]
      )
      titleLabel.attributedText = stringWithFormat
      titleLabel.sizeToFit()
      self.navigationItem.titleView = titleLabel

  }
  
  private func changeRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: AgencyProfileEditConstants.EditAgencyProfileViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(popThisViewController))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func addObserverToKeyboardNotification() {
    
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector: #selector(keyboardWillDisappear),
                                                     name: UIKeyboardWillHideNotification,
                                                     object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self,
                                              selector: #selector(keyBoardWillAppear),
                                                  name: UIKeyboardDidShowNotification,
                                                object: nil)
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 239.0/255.0, green: 255.0/255.0, blue: 145.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 250.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func viewDidLoad() {
    
    self.addGestureToDismissKeyboard()
    self.createAndAddFlipCard()
    self.createSaveChangesButton()
    
  }
  
  private func createAndAddFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    //createTheFrontCard
    self.createFrontViewForFlipCard(frameForViewsOfCard)
    
    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
    
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: scrollViewFrontFlipCard, viewTwo: blankView)
    self.createButtonsForFlipCard()
    
    self.view.addSubview(flipCard )
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    let contentSizeOfScrollView = CGSize.init(width: frameForCards.size.width * CGFloat(kNumberOfCardsInScrollViewMinusOne),
                                             height: frameForCards.size.height)
    
    scrollViewFrontFlipCard = UIScrollView.init(frame: frameForCards)
    scrollViewFrontFlipCard.contentSize = contentSizeOfScrollView
    scrollViewFrontFlipCard.scrollEnabled = false
//    scrollViewFrontFlipCard.directionalLockEnabled = true
//    scrollViewFrontFlipCard.alwaysBounceHorizontal = false
//    scrollViewFrontFlipCard.alwaysBounceVertical = false
//    scrollViewFrontFlipCard.pagingEnabled = true
    
    //------------------------------------------SCREENS
    
    let editCriteria = CriteriaAgencyProfileEditView.init(frame: frameForCards)
    
    participateView = ParticipateInView.init(frame: CGRect.init(x: frameForCards.size.width,
      y: 0.0 ,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    let exclusiveView = ExclusiveView.init(frame: CGRect.init(x: frameForCards.size.width * 2.0,
      y: 0.0 ,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    casesView = CasesView.init(frame: CGRect.init(x: frameForCards.size.width * 3.0,
      y: 0.0,
      width:frameForCards.size.width,
      height:frameForCards.size.height))
    casesView.delegate = self
    
    skillsView = SkillsView.init(frame: CGRect.init(x: frameForCards.size.width * 4.0,
      y: 0.0,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    skillsView.getAllSkillsFromServer()
    
    profileView = ProfileView.init(frame: CGRect.init(x: frameForCards.size.width * 5.0,
      y: 0.0,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    profileView.delegate = self
    
    scrollViewFrontFlipCard.addSubview(editCriteria)
    scrollViewFrontFlipCard.addSubview(participateView)
    scrollViewFrontFlipCard.addSubview(exclusiveView)
    scrollViewFrontFlipCard.addSubview(casesView)
    scrollViewFrontFlipCard.addSubview(skillsView)
    scrollViewFrontFlipCard.addSubview(profileView)

  }
  
  private func createButtonsForFlipCard() {
    leftButton = nil
    rightButton = nil
    
    
    let sizeForButtons = CGSize.init(width: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 49.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForLeftButton = CGRect.init(x: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 24.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: sizeForButtons.width,
                                         height:sizeForButtons.height)
    
    let frameForRightButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 24.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: sizeForButtons.width,
                                          height: sizeForButtons.height)
    
    let leftButtonImage = UIImage(named: "navNext") as UIImage?
    let rightButtonImage = UIImage(named: "navPrev") as UIImage?
    
    leftButton = UIButton.init(frame: frameForLeftButton)
//    leftButton.backgroundColor = UIColor.redColor()
    rightButton = UIButton.init(frame: frameForRightButton)
//    rightButton.backgroundColor = UIColor.redColor()
    
    leftButton.setImage(leftButtonImage, forState: .Normal)
    rightButton.setImage(rightButtonImage, forState: .Normal)
    
    leftButton.addTarget(self, action: #selector(moveScrollViewToLeft), forControlEvents: .TouchUpInside)
    rightButton.addTarget(self, action: #selector(moveScrollViewToRight), forControlEvents: .TouchUpInside)
    
    if actualPage == 0 {
      self.hideLeftButtonOfMainScrollView()
    }
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
  }
  
  private func createSaveChangesButton() {
    
    if saveChangesButton != nil {
      
      saveChangesButton = nil
      
    }
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.EditAgencyProfileViewController.saveChangesButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: AgencyProfileEditConstants.EditAgencyProfileViewController.saveChangesButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.flipCard.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: self.flipCard.frame.size.width,
                                height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    saveChangesButton = UIButton.init(frame: frameForButton)
    saveChangesButton.addTarget(self,
                             action: #selector(requestToEveryScreenToSave),
                             forControlEvents: .TouchUpInside)
    saveChangesButton.backgroundColor = UIColor.blackColor()
    saveChangesButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveChangesButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.flipCard.addSubview(saveChangesButton)
    
  }

  
  @objc private func moveScrollViewToLeft() {
    
    if actualPage > 0 {
      
      actualPage = actualPage - 1
      
      if actualPage == 0 {
        
        self.hideLeftButtonOfMainScrollView()
        
      }
      
      if actualPage < kNumberOfCardsInScrollViewMinusOne && self.rightButton.alpha == 0.0 {
        
        self.showRightButtonOfMainScrollView()
        
      }
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  @objc private func moveScrollViewToRight() {
    
    if actualPage < kNumberOfCardsInScrollViewMinusOne {
      
      actualPage = actualPage + 1
      
      if actualPage == kNumberOfCardsInScrollViewMinusOne {
        
        self.hideRightButtonOfMainScrollView()
        
      }
      
      if actualPage > 0 && self.leftButton.alpha == 0.0 {
        
        self.showLeftButtonOfMainScrollView()
        
      }
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  private func hideLeftButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.leftButton.alpha = 0.0
      
    }
    
  }
  
  private func hideRightButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.rightButton.alpha = 0.0
      
    }
    
  }
  
  private func showLeftButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.leftButton.alpha = 1.0
      
    }
    
  }
  
  private func showRightButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.rightButton.alpha = 1.0
      
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.addObserverToKeyboardNotification()
  
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    super.viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
  }
  
  private func addGestureToDismissKeyboard() {
    
    let tapForHideKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
    tapForHideKeyboard.numberOfTapsRequired = 1
    
    self.view.addGestureRecognizer(tapForHideKeyboard)
    
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
        
        if rawCase["id"] as? String != nil {
          newCaseId = rawCase["id"] as! String
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
        if rawCase["case_image_thumb"] as? String != nil{
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
      
    }
    
  }
  
  @objc private func keyBoardWillAppear(notification:NSNotification) {
    
    if isKeyboardAlreadyShown == false {
    
      let userInfo:NSDictionary = notification.userInfo!
      let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
      let keyboardRectangle = keyboardFrame.CGRectValue()
      let keyboardHeight = keyboardRectangle.height

      lastFrameForFlipCard = flipCard.frame
      let newFrameForFlipCard = CGRect.init(x: flipCard.frame.origin.x,
                                          y: flipCard.frame.origin.y - ((keyboardHeight - 100.0) * UtilityManager.sharedInstance.conversionHeight),
                                      width: flipCard.frame.size.width,
                                     height: flipCard.frame.size.height)
    
      UIView.animateWithDuration(0.35,
        animations: {
          self.flipCard.frame = newFrameForFlipCard
        }) { (finished) in
          if finished {
          
          //Do something
            self.isKeyboardAlreadyShown = true
          
          }
      }
    }
    
  }
  
  @objc private func keyboardWillDisappear(notification: NSNotification) {
    
    if isKeyboardAlreadyShown == true {
    
      UIView.animateWithDuration(0.35,
        animations: {
          self.flipCard.frame = self.lastFrameForFlipCard
        }) { (finished) in
          if finished {
  
            //Do something
            self.isKeyboardAlreadyShown = false
        
          }
        }
    }
  }
  
  @objc private func requestToEveryScreenToSave() {
    //this for every screen
    
    UtilityManager.sharedInstance.showLoader()
    
    //Profile Data and Participe In
    let valuesFromParticipateView = self.participateView.getTheValuesSelected()
    self.profileView.saveChangesOfAgencyProfile(valuesFromParticipateView)
    
//    //Skills Data
//    let paramsFromSkills = self.skillsView.getParamsToSaveDataOfSkills()
//    RequestToServerManager.sharedInstance.requestToSaveDataFromSkills(paramsFromSkills)
    
    
  }
  
  //MARK: - CasesViewDelegate
  
  func flipCardAndShowCreateNewCase() {
    
    createCaseView = nil
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    createCaseView = CreateCaseView.init(frame: frameForViewsOfCard)
    createCaseView!.delegate = self
    createCaseView!.hidden = true
    flipCard.setSecondView(createCaseView!)
    flipCard.flip()
    
  }
  
  func flipCardAndShowPreviewOfCase(caseData: Case) {
    
    createCaseView = nil
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    createCaseView = CreateCaseView.init(frame: frameForViewsOfCard, caseData: caseData)
    createCaseView!.delegate = self
    createCaseView!.hidden = true
    flipCard.setSecondView(createCaseView!)
    flipCard.flip()

  }
  
  @objc private func dismissKeyboard() {
    
    self.view.endEditing(true)
    
  }
  
  @objc private func popThisViewController() {
    
    self.requestToShowTabBar()
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  private func requestToShowTabBar() {
    
    self.delegate?.requestToShowTabBarFromEditAgencyProfileViewControllerDelegate()
    
  }
  
  func deleteCaseSelectedFromPreviewVimeoYoutubePlayer(caseData: Case) {
    
    RequestToServerManager.sharedInstance.requestForDeleteAgencyCase(caseData) { 
      self.casesView.createAgainAllCasesCardInfo()
    }
  }
  
  //MARK: - CreateCaseViewDelegate
  
  func createCaseRequest(parameters: [String : AnyObject]) {
    
    var newParameters = parameters
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/success_cases"
    
    let headers = [
      "Content-Type" : "application/json",
      "Authorization": UtilityManager.sharedInstance.apiToken
    ]
    
    let keyauth_token = "auth_token"
    let auth_token = newParameters[keyauth_token]
    
    let keyfilename = "filename"
    let filename = newParameters[keyfilename]
    
    var params = newParameters["success_case"] as! [String:AnyObject]
 
    let imageData = params["case_image"]
    params.removeValueForKey("case_image")
    
    let keyAgency_id = "agency_id"
    let agency_id_string = params[keyAgency_id] as! String
    params.removeValueForKey(keyAgency_id)
    
//    var caseName = newParamters["name"]
//    var caseDescription = newParamters["description"]
//    var caseURL = newParamters["url"]
//    var caseAgencyID = newParamters["agency_id"]
    
    let caseName = params["name"]
    let caseDescription = params["description"]
    let caseURL = params["url"]
    
    
    
    Alamofire.upload(.POST, urlToRequest, headers: headers, multipartFormData:{
      multipartFormData in
     
      if imageData != nil {
        multipartFormData.appendBodyPart(data: imageData as! NSData,
              name: "case_image",
          fileName: "AgencyExample.png",
          mimeType: "image/png")
      }
      
      multipartFormData.appendBodyPart(data: auth_token!.dataUsingEncoding(NSUTF8StringEncoding)!, name: keyauth_token)
      
      multipartFormData.appendBodyPart(data: filename!.dataUsingEncoding(NSUTF8StringEncoding)!, name: keyfilename)
      
      multipartFormData.appendBodyPart(data: caseName!.dataUsingEncoding(NSUTF8StringEncoding)!,
      name: "success_case[name]")
      
      multipartFormData.appendBodyPart(data: caseDescription!.dataUsingEncoding(NSUTF8StringEncoding)!,
      name: "success_case[description]")
      
      multipartFormData.appendBodyPart(data: caseURL!.dataUsingEncoding(NSUTF8StringEncoding)!,
      name: "success_case[url]")
      
      multipartFormData.appendBodyPart(data: agency_id_string.dataUsingEncoding(NSUTF8StringEncoding)!,
      name: "success_case[agency_id]")
      
      }, encodingCompletion:{ encodingResult in
        
        switch encodingResult {
        case .Success(let upload, _, _):
          print("SUCCESSFUL")
          upload.responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            
            if response.response?.statusCode >= 200 && response.response?.statusCode <= 350 {
              
              let rawImage = imageData as? NSData
              
              if rawImage != nil {
                
                let imageCase = UIImage.init(data: rawImage!)
                
                let newCaseData = Case(id: nil,
                  name: caseName as! String,
                  description: caseDescription as! String,
                  url: caseURL as? String,
                  case_image_url: nil,
                  case_image_thumb: nil,
                  case_image: imageCase,
                  agency_id: AgencyModel.Data.id)
                
                
//                let newCaseData = Case(caseName: caseName as! String, caseDescription: caseDescription as! String, caseWebLink: caseURL as? String, caseImage: imageCase)
                
                self.casesView.addCaseToViewsOfCase(newCaseData)
                
              } else {
                
                let newCaseData = Case(id: nil,
                                     name: caseName as! String,
                              description: caseDescription as! String,
                                      url: caseURL as? String,
                           case_image_url: nil,
                         case_image_thumb: nil,
                               case_image: nil,
                                agency_id: AgencyModel.Data.id)
                
//                let newCaseData = Case(caseName: caseName as! String, caseDescription: caseDescription as! String, caseWebLink: caseURL as? String, caseImage: nil)
                
                self.casesView.addCaseToViewsOfCase(newCaseData)
                
              }
          
              self.flipCard.flip()
              self.createButtonsForFlipCard()
              self.createSaveChangesButton()
              
            }
            
            
            if let JSON = response.result.value {
              print("JSON: \(JSON)")
            }
          }
        
        case .Failure(let error):
          print(error)
        
        }
      }
    )
  }
  
  func askingForDeleteCaseImage() {
    
    let alertController = UIAlertController(title: "Borrar imagen de caso", message: "¿Estás seguro que deseas eleminar la imagen para este caso?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
    }
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      self.createCaseView?.deleteImageOfNewCase()
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  func cancelCreateCase() {
    flipCard.flip()
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
    blankView.hidden = true
    flipCard.setSecondView(blankView)
    self.createButtonsForFlipCard()
    self.createSaveChangesButton()
  }
  
  func selectCaseImageFromLibrary() {
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
      imagePicker.allowsEditing = true
      
      requestImageForCase = true
      
      self.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }
  
  //MARK: - ProfileViewDelegate
  
  func selectProfileImageFromLibrary() {
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      imagePicker.allowsEditing = true
      
      requestImageForProfile = true
      
      self.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
    if requestImageForProfile == true {
      
      
      self.profileView.changeProfileImageView(image)
      requestImageForProfile = false
      self.goToLastPage()

    }else
      if requestImageForCase == true {
        
        self.createCaseView?.changeCaseImageView(image)
        requestImageForCase = false
        
    }

    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
  func asKForDeleteProfileImage() {
    
    let alertController = UIAlertController(title: "Borrar Foto de Perfil", message: "¿Estás seguro que deseas eleminar la imagen de perfil?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in

    }
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      self.profileView.deleteProfileImage()
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  private func goToLastPage() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(kNumberOfCardsInScrollViewMinusOne), y: 0.0)
    
    scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: false)
    
  }
  
  func saveChangesFromEditProfileView(parameters: [String:AnyObject]) {
    
    var newParameters = parameters
    
    let urlToRequest = "http://amap-dev.herokuapp.com/api/agencies/update"
    
    let headers = [
      "Content-Type" : "application/json",
      "Authorization": UtilityManager.sharedInstance.apiToken
    ]
    
    let key_id = "id"
    let id_string = newParameters[key_id] as? String
    
    let key_auth_token = "auth_token"
    let auth_token = newParameters[key_auth_token] as? String
    
    let key_filename = "filename"
    let filename = newParameters[key_filename] as? String
    
    var params = newParameters["agency"] as! [String:AnyObject]
    
    let key_name = "name"
    let name = params[key_name] as? String
    
    let imageData = params["case_image"]
    
    let key_phone = "phone"
    let phone = params[key_phone] as? String
    
    let key_contact_email = "contact_email"
    let contact_email = params[key_contact_email] as? String
    
    let key_address = "address"
    let address = params[key_address] as? String
    
    let key_latitude = "latitude"
    let latitude = params[key_latitude] as? String
    
    let key_longitude = "longitude"
    let longitude = params[key_longitude]
    
    let key_website_url = "website_url"
    let website_url = params[key_website_url] as? String
    
    let key_num_employees = "num_employees"
    let num_employees = params[key_num_employees] as? String
    
    let key_golden_pitch = "golden_pitch"
    let golden_pitch = params[key_golden_pitch] as? String
    
    let key_silver_pitch = "silver_pitch"
    let silver_pitch = params[key_silver_pitch] as? String
    
    let key_high_risk_pitch = "high_risk_pitch"
    let high_risk_pitch = params[key_high_risk_pitch] as? String
    
    let key_medium_risk_pitch = "medium_risk_pitch"
    let medium_risk_pitch = params[key_medium_risk_pitch] as? String
    
    Alamofire.upload(.POST, urlToRequest, headers: headers, multipartFormData:{
      multipartFormData in
      
      if imageData != nil {
        multipartFormData.appendBodyPart(data: imageData as! NSData,
          name: "logo",
          fileName: "AgencyProfileImage.png",
          mimeType: "image/png")
      }
      
      multipartFormData.appendBodyPart(data: id_string!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key_id)
      
      if auth_token != nil {
        multipartFormData.appendBodyPart(data: auth_token!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key_auth_token)
        
      }
      
      if filename != nil {
        multipartFormData.appendBodyPart(data: filename!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key_filename)
        
      }
      
      if name != nil {
        multipartFormData.appendBodyPart(data: name!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[name]")
        
      }
      
      if phone != nil {
        multipartFormData.appendBodyPart(data: phone!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[phone]")
        
      }
      
      if contact_email != nil {
        multipartFormData.appendBodyPart(data: contact_email!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[contact_email]")
        
      }
      
      if address != nil {
        multipartFormData.appendBodyPart(data: address!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[address]")
        
      }
      
      if latitude != nil {
        multipartFormData.appendBodyPart(data: latitude!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[latitude]")
        
      }
      
      if longitude != nil {
        multipartFormData.appendBodyPart(data: longitude!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[longitude]")
        
      }
      
      if website_url != nil {
        multipartFormData.appendBodyPart(data: website_url!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[website_url]")
        
      }
      
      if num_employees != nil {
        multipartFormData.appendBodyPart(data: num_employees!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[num_employees]")
        
      }
      
      if golden_pitch != nil {
        multipartFormData.appendBodyPart(data: golden_pitch!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[golden_pitch]")
        
      }
      
      if silver_pitch != nil {
        multipartFormData.appendBodyPart(data: silver_pitch!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[silver_pitch]")
        
      }
      
      if high_risk_pitch != nil {
        multipartFormData.appendBodyPart(data: high_risk_pitch!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[high_risk_pitch]")
        
      }
      
      if medium_risk_pitch != nil {
        multipartFormData.appendBodyPart(data: medium_risk_pitch!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "agency[medium_risk_pitch]")
        
      }
      
      }, encodingCompletion:{ encodingResult in
        
        switch encodingResult {
        case .Success(let upload, _, _):
          print("SUCCESSFUL")
          upload.responseJSON { response in
            
            //Skills Data
            let paramsFromSkills = self.skillsView.getParamsToSaveDataOfSkills()
            RequestToServerManager.sharedInstance.requestToSaveDataFromSkills(paramsFromSkills) {
              
              RequestToServerManager.sharedInstance.requestForAgencyData {
                
                UtilityManager.sharedInstance.hideLoader()
                
              }
              
            }
            
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
              print("JSON: \(JSON)")
            }
          }
          
        case .Failure(let error):
          print(error)
          
        }
      }
    )
  }

}

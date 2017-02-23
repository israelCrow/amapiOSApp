//
//  EditCompanyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

protocol EditCompanyProfileViewControllerDelegate {
  
  func requestToShowTabBarFromEditCompanyProfileViewControllerDelegate()
  func requestToReloadData()
  
}

class EditCompanyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditCompanyProfileViewDelegate {
  
  private var flipCard: FlipCardView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  private var saveChangesButton: UIButton! = nil
  private var leftButton: UIButton! = nil
  private var rightButton: UIButton! = nil
  
  private var editProfile: EditCompanyProfileView! = nil
//  private var editConflicts: EditConflictsView! = nil
  
  private var actualPage = 0
  
  private let kNumberOfCardsInScrollViewMinusOne = 1
  
  var delegate: EditCompanyProfileViewControllerDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
    self.addSomeGestures()
    
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
      string: "Editar perfil de marca",
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
  
  private func addSomeGestures() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
    tapGesture.numberOfTapsRequired = 1
    
    self.view.addGestureRecognizer(tapGesture)
    
  }
  
  override func viewDidLoad() {
    
//    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//    
//    if savedPhotoAndSavedName == false {
//      
//      let welcomeScreen = WelcomeScreenTutorialView.init(frame: CGRect.init())
//      let rootViewController = UtilityManager.sharedInstance.currentViewController()
//      rootViewController.view.addSubview(welcomeScreen)
//      
//    }
    
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
    
//    self.createButtonsForFlipCard()
    
    self.view.addSubview(flipCard )
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    let contentSizeOfScrollView = CGSize.init(width: frameForCards.size.width * CGFloat(kNumberOfCardsInScrollViewMinusOne + 1),
                                              height: frameForCards.size.height)
    
    scrollViewFrontFlipCard = UIScrollView.init(frame: frameForCards)
    scrollViewFrontFlipCard.contentSize = contentSizeOfScrollView
    scrollViewFrontFlipCard.scrollEnabled = false
    //    scrollViewFrontFlipCard.directionalLockEnabled = true
    //    scrollViewFrontFlipCard.alwaysBounceHorizontal = false
    //    scrollViewFrontFlipCard.alwaysBounceVertical = false
    //    scrollViewFrontFlipCard.pagingEnabled = true
    
    //------------------------------------------SCREENS
    
    editProfile = EditCompanyProfileView.init(frame: frameForCards)
    editProfile.delegate = self
    scrollViewFrontFlipCard.addSubview(editProfile)
    
//    editConflicts = EditConflictsView.init(frame: CGRect.init(x: frameForCards.size.width,
//      y: 0.0 ,
//      width: frameForCards.size.width,
//      height: frameForCards.size.height))
//
//    scrollViewFrontFlipCard.addSubview(editConflicts)
    
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
      
    } else
      if actualPage == kNumberOfCardsInScrollViewMinusOne {
        
        self.hideRightButtonOfMainScrollView()
        
    }
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
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
                                action: #selector(saveChangesButtonPressed),
                                forControlEvents: .TouchUpInside)
    saveChangesButton.backgroundColor = UIColor.blackColor()
    saveChangesButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveChangesButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.flipCard.addSubview(saveChangesButton)
    
    if actualPage == 4 {
      
      self.saveChangesButton.alpha = 0.0
      
    }
    
  }
  
  @objc private func saveChangesButtonPressed() {
    
    self.requestToEveryScreenToSave(){
      
    UtilityManager.sharedInstance.showLoader()
      
    RequestToServerManager.sharedInstance.requestForCompanyData({
    
      UtilityManager.sharedInstance.hideLoader()
      
    })
      
    self.editProfile.thereAreChanges = false
//    self.editConflicts.thereAreChanges = false
//      self.criteriaView.thereAreChanges = false
//      self.participateView.thereAreChanges = false
//      self.exclusiveView.thereAreChanges = false
//      self.skillsView.thereAreChanges = false
//      self.profileView.thereAreChanges = false
      
    }
    
  }
  
  @objc private func requestToEveryScreenToSave(actionsToMakeAfterExecuting: () -> Void) {
    //this for every screen
    
    editProfile.saveChangesOfCompanyProfile(actionsToMakeAfterExecuting)
    
//    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//    
//    if savedPhotoAndSavedName == false && profileView.isAgencyNameAndAgencyImageWithInfo() == false {
//      
//      self.showMessageOfMandatoryInfo()
//      
//    } else {
//      
//      self.criteriaView.saveCriterionsSelected()
//      
//      self.exclusiveView.requestToSaveNewBrands()
//      
//      //Profile Data and Participe In
//      let valuesFromParticipateView = self.participateView.getTheValuesSelected()
//      
//      self.profileView.saveChangesOfAgencyProfile(valuesFromParticipateView, actionsToMakeAfterExecution: {
//        actionsToMakeAfterExecuting()
//        
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//        
//      })
//  
//    }
    
  }

  //MARK: - EditCompanyProfileViewDelegate
  
  func selectProfileImageFromLibrary() {
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      
      let imagePicker = UIImagePickerController()
      imagePicker.navigationBar.barTintColor = UIColor.init(white: 1.0, alpha: 1.0)
//      imagePicker.navigationBar.tintColor = UIColor.init(white: 1.0, alpha: 1.0)
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      imagePicker.allowsEditing = true
    
      self.presentViewController(imagePicker, animated: true, completion: nil)
      
    }
    
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
      self.editProfile.changeProfileImageView(image)
      self.editProfile.thereAreChanges = true
      //self.goToFirstPage()

    
    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
  func asKForDeleteProfileImage() {
    
    let alertController = UIAlertController(title: "Borrar Foto de Perfil", message: "¿Estás seguro que deseas eliminar la imagen de perfil?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
    }
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.editProfile.deleteProfileImage()
      
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  func saveChangesFromEditCompanyProfileView(parameters: [String:AnyObject], actionsToMakeAfterExecution: () -> Void) {
    
    UtilityManager.sharedInstance.showLoader()
    
    var newParameters = parameters
    
    let urlToRequest = "https://amap-prod.herokuapp.com/api/companies/update"
    
    let headers = [
      "Content-Type" : "application/json",
      "Authorization": UtilityManager.sharedInstance.apiToken
    ]
    
    let key_id = "id"
    let id_string = newParameters[key_id] as? String
    
    let key_auth_token = "auth_token"
    let auth_token = newParameters[key_auth_token] as? String
    
    let keyDelete_image = "delete_image"
    let deleteImageBool: Bool = (newParameters[keyDelete_image] as? Bool != nil ? newParameters[keyDelete_image] as! Bool : false)
    var deleteImageInt: Int = (deleteImageBool == true ? 1 : 0)
    
    let keyFile_name = "filename"
    let filename = newParameters["filename"] as? String
    
    let imageData = newParameters["logo"]
    
    let companyData = newParameters["company"] as! [String: AnyObject]
    
    let key_name = "name"
    let name = companyData[key_name] as? String
    
    let key_contact_name = "contact_name"
    let contact_name = companyData[key_contact_name] as? String
    
    let key_contact_email = "contact_email"
    let contact_email = companyData[key_contact_email] as? String
    
    let key_contact_position = "contact_position"
    let contact_position = companyData[key_contact_position] as? String
    
    Alamofire.upload(.POST, urlToRequest, headers: headers, multipartFormData:{
      multipartFormData in
      
      if imageData != nil {
        multipartFormData.appendBodyPart(data: imageData as! NSData,
          name: "logo",
          fileName: "CompanyProfileImage.png",
          mimeType: "image/png")
        
        multipartFormData.appendBodyPart(data: filename!.dataUsingEncoding(NSUTF8StringEncoding)!, name: keyFile_name)
        
      }
      
      if deleteImageBool == true {
        
        multipartFormData.appendBodyPart(data: NSData(bytes: &deleteImageInt, length: sizeof(Int)), name: keyDelete_image)
        
      }
      
      multipartFormData.appendBodyPart(data: id_string!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key_id)
      
      if auth_token != nil {
        multipartFormData.appendBodyPart(data: auth_token!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key_auth_token)
        
      }
      
      if name != nil {
        multipartFormData.appendBodyPart(data: name!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "company[name]")
        
      }
      
      if contact_name != nil {
        multipartFormData.appendBodyPart(data: contact_name!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "company[contact_name]")
        
      }
      
      if contact_email != nil {
        multipartFormData.appendBodyPart(data: contact_email!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "company[contact_email]")
        
      }
      
      if contact_position != nil {
        multipartFormData.appendBodyPart(data: contact_position!.dataUsingEncoding(NSUTF8StringEncoding)!, name: "company[contact_position]")
        
      }
      
      
      }, encodingCompletion:{ encodingResult in
        
        switch encodingResult {
        case .Success(let upload, _, _):
          print("SUCCESSFUL")
          upload.responseJSON { response in
            
            //Skills Data
            //            let paramsFromSkills = self.skillsView.getParamsToSaveDataOfSkills()
            //            RequestToServerManager.sharedInstance.requestToSaveDataFromSkills(paramsFromSkills) {
            //
            //              RequestToServerManager.sharedInstance.requestForAgencyData {
            //
            UtilityManager.sharedInstance.hideLoader()
            actionsToMakeAfterExecution()
            //
            //              }
            //
            //            }
            
            //            print(response.request)  // original URL request
            //            print(response.response) // URL response
            //            print(response.data)     // server data
            //            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
              print("JSON: \(JSON)")
            }
          }
          
        case .Failure(let error):
          
          UtilityManager.sharedInstance.hideLoader()
          print(error)
          
        }
      }
    )
  }

  
  func showMessageOfMandatoryInfo() {
    
//    let alertController = UIAlertController(title: "AVISO",
//                                            message: "¡Necesitas subir tu logo para continuar!",
//                                            preferredStyle: UIAlertControllerStyle.Alert)
//    
//    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
//      
//      
//      
//    }
//    
//    alertController.addAction(okAction)
//    self.presentViewController(alertController, animated: true, completion: nil)
    
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
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 214.0/255.0, green: 240.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 40.0/255.0, green: 255.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  @objc private func popThisViewController() {
    
    if editProfile.thereAreChanges == true {
      
        let alertController = UIAlertController(title: "Cambios detectados", message: "¿Deseas guardar los cambios realizados?", preferredStyle: UIAlertControllerStyle.Alert)
      
      let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
        
        self.requestToShowTabBar()
        self.navigationController?.popViewControllerAnimated(true)
        
      }
      
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
        
        self.editProfile.saveChangesOfCompanyProfile({ 
          
          UtilityManager.sharedInstance.showLoader()
          
          RequestToServerManager.sharedInstance.requestForCompanyData({ 
            
            self.requestToShowTabBar()
            self.navigationController?.popViewControllerAnimated(true)
            UtilityManager.sharedInstance.hideLoader()
            
          })
          
//          self.requestToShowTabBar()
//          self.navigationController?.popViewControllerAnimated(true)
          
        })
        
      }
      
      alertController.addAction(cancelAction)
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    } else {
      
      self.requestToShowTabBar()
      self.navigationController?.popViewControllerAnimated(true)
      
    }
    
  }
  
  private func requestToShowTabBar() {
    
    self.delegate?.requestToShowTabBarFromEditCompanyProfileViewControllerDelegate()
    
  }
  
  @objc private func dismissKeyboard() {
    
    self.view.endEditing(true)
    
  }
  
  override func viewDidDisappear(animated: Bool) {
    
    self.delegate?.requestToReloadData()
    
  }
  
  
}

//
//  CreateAddNewPitchAndWriteProjectNameViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateAddNewPitchAndWriteProjectNameViewControllerDelegate {
  
  func requestToShowTabBarFromCreateAddNewPitchAndWriteProjectNameViewControllerDelegate()
  
}

class CreateAddNewPitchAndWriteProjectNameViewController: UIViewController, AddPitchAndWriteProjectNameViewDelegate {
  
  private var addPitchWriteProjectName: AddPitchAndWriteProjectNameView! = nil
  private var companyData: CompanyModelData! = nil
  private var brandData: BrandModelData! = nil
  
  var delegateForShowTabBar: CreateAddNewPitchAndWriteProjectNameViewControllerDelegate?
  
  init(newCompanyData: CompanyModelData, newBrandData: BrandModelData) {
    
    companyData = newCompanyData
    brandData = newBrandData
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    self.addGestures()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    
    self.editNavigationController()
    self.createAddPitchWriteCompanyName()
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: VisualizePitchesConstants.CreateAddNewPitchAndWriteBrandNameViewController.navigationLeftButtonText,
                                     style: UIBarButtonItemStyle.Plain,
                                     target: self,
                                     action: #selector(navigationLeftButtonPressed))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    backButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.leftBarButtonItem = backButton
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.CreateAddNewPitchAndWriteBrandNameViewController.navigationBarTitleText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  private func changeNavigationRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.CreateAddNewPitchAndWriteBrandNameViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(navigationRightButtonPressed))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createAddPitchWriteCompanyName() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: widthOfCard,
                                   height: heightOfCard)
    
    addPitchWriteProjectName = AddPitchAndWriteProjectNameView.init(frame: frameForCard, newCompanyData: companyData, newBrandData: brandData)
    addPitchWriteProjectName.delegate = self
    
    self.view.addSubview(addPitchWriteProjectName)
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllProjectsPitches(brandData.id) { allProjects in
      
      self.addPitchWriteProjectName.setArrayOfAllProjectsPitches(allProjects)
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 187.0/255.0, green: 145.0/255.0, blue: 2555.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 117.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @objc private func navigationLeftButtonPressed() {
    
    self.popMyself()
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  private func popMyself() {
    
    self.delegateForShowTabBar?.requestToShowTabBarFromCreateAddNewPitchAndWriteProjectNameViewControllerDelegate()
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  //MARK: - AddPitchAndWriteProjectNameViewDelegate
  
  func pushCreateAddNewPitchAndWhichCategoryIsViewController(newProjectPitchData: ProjectPitchModelData?, selectedProjectPitchData: ProjectPitchModelData?) {
  
    if newProjectPitchData != nil && selectedProjectPitchData == nil {
      
      newProjectPitchData!.brandData = brandData
      newProjectPitchData!.companyData = companyData
      newProjectPitchData!.arrayOfPitchCategories = [PitchSkillCategory]()
      
      
      let preEvaluatePitch = PreEvaluatePitchViewController(newPitchData: newProjectPitchData!)
      self.navigationController?.pushViewController(preEvaluatePitch, animated: true)
      
      
//      let createAndWriteWhichCategoryIs = CreateAddNewPitchAndWriteCategoryTypeViewController(newProjectPitchData: newProjectPitchData!)
//      self.navigationController?.pushViewController(createAndWriteWhichCategoryIs, animated: true)
      
    }else
      if newProjectPitchData == nil && selectedProjectPitchData != nil {
        
        selectedProjectPitchData!.brandData = brandData
        selectedProjectPitchData!.companyData = companyData
        selectedProjectPitchData!.arrayOfPitchCategories = [PitchSkillCategory]()
        
        let params: [String: AnyObject] = [
          "auth_token": UserSession.session.auth_token,
          "pitch_id" : selectedProjectPitchData!.id
        ]
        
        UtilityManager.sharedInstance.showLoader()
    
        RequestToServerManager.sharedInstance.requestToCreateAVoidEvaluationOfProjectPitch(params, actionsToMakeAfterSuccessfullyCreateAVoidPitchEvaluation: { (newIdOfVoidPitchEvaluation) in
          
          selectedProjectPitchData!.voidPitchEvaluationId = newIdOfVoidPitchEvaluation
        
          let preEvaluatePitch = PreEvaluatePitchViewController(newPitchData: selectedProjectPitchData!)
          
          UtilityManager.sharedInstance.hideLoader()
          
          self.navigationController?.pushViewController(preEvaluatePitch, animated: true)
          preEvaluatePitch.flipCardToOk()
          
          
          }, actionsToMakeWhenPitchEvaluationAlreadyCreated: { (errorMessage) in
            
            UtilityManager.sharedInstance.hideLoader()
            
            let alertController = UIAlertController(title: "ERROR",
              message: "Ya tenemos registrado un proyecto con la misma información para tu agencia, ve a editar a tus tarjetas de pitches o crea un nuevo proyecto",
              preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
              
              print()
              
            }
            
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        })
        
        
      
//        let createAndWriteWhichCategoryIs = CreateAddNewPitchAndWriteCategoryTypeViewController(newProjectPitchData: selectedProjectPitchData!)
//        self.navigationController?.pushViewController(createAndWriteWhichCategoryIs, animated: true)
      
      }
  

    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.view.endEditing(true)
    
  }
  
}


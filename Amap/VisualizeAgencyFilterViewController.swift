//
//  VisualizeAgencyFilterViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

class VisualizeAgencyFilterViewController: UIViewController, LookForAgencyViewDelegate {
  
  private var flipCard: FlipCardView! = nil
  private var frontViewOfFlipCard: UIView! = nil
  private var lookForAgencyView: LookForAgencyView! = nil
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    self.initInterface()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
    //Checar si va aquí o va en otro lugar
    
    //    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
    //
    //    if savedPhotoAndSavedName == false {
    //
    //      UIApplication.sharedApplication().sendAction((self.navigationItem.leftBarButtonItem?.action)!,
    //                                                   to: self.navigationItem.leftBarButtonItem?.target,
    //                                                   from: nil,
    //                                                   forEvent: nil)
    //
    //    }
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: "",
                                     style: UIBarButtonItemStyle.Plain,
                                     target: self,
                                     action: nil)
    
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
      string: "Directorio Agencias",
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
    
    let rightButton = UIBarButtonItem(title: "",
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: nil)
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func initInterface() {
    
    self.createAndAddFlipCard()
    
  }
  
  private func createAndAddFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    //createTheFrontCard
    self.createFrontViewForFlipCard(frameForViewsOfCard)
    
    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
    //
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: frontViewOfFlipCard, viewTwo: blankView)
    self.view.addSubview(flipCard)
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    frontViewOfFlipCard = UIView.init(frame: frameForCards)
    frontViewOfFlipCard.backgroundColor = UIColor.whiteColor()
    
    lookForAgencyView = LookForAgencyView.init(frame: frameForCards,
                          newArrayOfAgenciesToFilter: [GenericAgencyData]())
    lookForAgencyView.delegate = self
    
    frontViewOfFlipCard.addSubview(lookForAgencyView)
    
  }
  
  
  override func viewDidLoad() {
    
//    UtilityManager.sharedInstance.showLoader()
//    
//    RequestToServerManager.sharedInstance.requestToGetAllAgencies { (allAgencies) in
//      
//      self.lookForAgencyView.setArrayOfAllAgencies(allAgencies)
//      
//      UtilityManager.sharedInstance.hideLoader()
//      
//    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
    if UserSession.session.role == "4" {
      
      AgencyModel.Data.reset()
      lookForAgencyView.resetValues()
      
      
    }
    
  }
  
  //MARK: - LookForAgencyViewDelegate
  
  func requestToServerToLookFor(params: [String: AnyObject]) {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAgenciesBySearch(params) { (allAgencies) in
      
      self.lookForAgencyView.setArrayOfAllAgencies(allAgencies)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
    
  }
  
  func showInfoOfThisSelectedAgency(basicDataOfAgency: GenericAgencyData) {

    UtilityManager.sharedInstance.showLoader()
    
    AgencyModel.Data.id = basicDataOfAgency.id
    
    RequestToServerManager.sharedInstance.requestForAgencyData { 
      
      let visualizeAgencyProfile = VisualizeAgencyProfileViewController()
      visualizeAgencyProfile.isFavoriteAgency = basicDataOfAgency.isFavorite
      self.navigationController?.pushViewController(visualizeAgencyProfile, animated: true)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  @objc private func pushEditCompanyProfile() {
    

    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 255.0/255.0, green: 208.0/255.0, blue: 145.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 117.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  
}


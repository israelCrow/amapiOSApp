//
//  EditAgencyProfileViewController.swift
//  Amap
//
//  Created by Mac on 8/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class EditAgencyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileViewDelegate {
    
  private let kEditAgencyProfile = "Editar Perfil Agencia"
  private let kNumberOfCardsInScrollViewMinusOne = 4
  
  private var flipCard: FlipCardView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  private var criteriaAgencyProfileEdit: CriteriaAgencyProfileEditView! = nil
  private var actualPage: Int! = 0
  private var lastFrameForFlipCard: CGRect! = nil
  private var isKeyboardAlreadyShown = false
  
//  private var criteriaView: CriterionView! = nil
//  private var participateView: ParticipateInView! = nil
//  private var exclusiveView: ExclusiveView! = nil
//  private var skillsView: SkillsView! = nil
  private var profileView: ProfileView! = nil

  override func loadView() {
    
    self.editNavigationBar()
    self.addObserverToKeyboardNotification()
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    
  }
    
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
//        self.changeRigthButtonItem()
        
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
    self.createAndAddFlipCard()
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
    scrollViewFrontFlipCard.userInteractionEnabled = true
//    scrollViewFrontFlipCard.directionalLockEnabled = true
//    scrollViewFrontFlipCard.alwaysBounceHorizontal = false
//    scrollViewFrontFlipCard.alwaysBounceVertical = false
//    scrollViewFrontFlipCard.pagingEnabled = true
    
    //------------------------------------------SCREENS
    
    let editCriteria = CriteriaAgencyProfileEditView.init(frame: frameForCards)
    
    let participateView = ParticipateInView.init(frame: CGRect.init(x: frameForCards.size.width,
      y: 0.0 ,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    let exclusiveView = ExclusiveView.init(frame: CGRect.init(x: frameForCards.size.width * 2.0,
      y: 0.0 ,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    let skillsView = SkillsView.init(frame: CGRect.init(x: frameForCards.size.width * 3.0,
      y: 0.0,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    profileView = ProfileView.init(frame: CGRect.init(x: frameForCards.size.width * 4.0,
      y: 0.0,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    profileView.delegate = self
    
    scrollViewFrontFlipCard.addSubview(editCriteria)
    scrollViewFrontFlipCard.addSubview(participateView)
    scrollViewFrontFlipCard.addSubview(exclusiveView)
    scrollViewFrontFlipCard.addSubview(skillsView)
    scrollViewFrontFlipCard.addSubview(profileView)

  }
  
  private func createButtonsForFlipCard() {
    
    let sizeForButtons = CGSize.init(width: 7.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 18.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForLeftButton = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 38.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: sizeForButtons.width,
                                         height:sizeForButtons.height)
    
    let frameForRightButton = CGRect.init(x: 253.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 38.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: sizeForButtons.width,
                                          height: sizeForButtons.height)
    
    let leftButtonImage = UIImage(named: "next") as UIImage?
    let rightButtonImage = UIImage(named: "prev") as UIImage?
    
    let leftButton = UIButton.init(frame: frameForLeftButton)
    let rightButton = UIButton.init(frame: frameForRightButton)
    
    leftButton.setImage(leftButtonImage, forState: .Normal)
    rightButton.setImage(rightButtonImage, forState: .Normal)
    
    leftButton.addTarget(self, action: #selector(moveScrollViewToLeft), forControlEvents: .TouchUpInside)
    rightButton.addTarget(self, action: #selector(moveScrollViewToRight), forControlEvents: .TouchUpInside)
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
  }
  
  @objc private func moveScrollViewToLeft() {
    
    if actualPage > 0 {
      
      actualPage = actualPage - 1
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  @objc private func moveScrollViewToRight() {
    
    if actualPage < kNumberOfCardsInScrollViewMinusOne {
      
      actualPage = actualPage + 1
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    super.viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
  }
  
  @objc private func keyBoardWillAppear(notification:NSNotification) {
    
    if isKeyboardAlreadyShown == false {
    
      let userInfo:NSDictionary = notification.userInfo!
      let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
      let keyboardRectangle = keyboardFrame.CGRectValue()
      let keyboardHeight = keyboardRectangle.height

      lastFrameForFlipCard = flipCard.frame
      let newFrameForFlipCard = CGRect.init(x: flipCard.frame.origin.x,
                                          y: flipCard.frame.origin.y - ((keyboardHeight - 70.0) * UtilityManager.sharedInstance.conversionHeight),
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
  
  //MARK: - ProfileViewDelegate
  
  func selectProfileImageFromLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
      imagePicker.allowsEditing = true
      self.presentViewController(imagePicker, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
    self.profileView.changeProfileImageView(image)
    self.dismissViewControllerAnimated(true, completion: nil);
    
  }
  
  
}

//
//  PitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PitchCardViewDelegate {
  
  func pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard()
  func createAndShowDetailedPitchView()
  func askForArchiveThisPitchCard(params: [String: AnyObject])
  func upSwipeDetectedInPitchCard()
  func showAlreadyArchivedMessage(alert: UIAlertController)
  func showMailToContactAmapFromPitchCardView(sender: PitchCardView)
  
}

class PitchCardView: UIView, GraphPartPitchCardViewDelegate {
  
  private var contentView: UIView! = nil
  private var addPitchButton: UIButton! = nil
  private var thumbsDownIcon: UIImageView! = nil
  private var graphPart: GraphPartPitchCardView! = nil
  private var detailedPart: DetailedPartPitchCardView! = nil
  private var pitchEvaluationByUserData: PitchEvaluationByUserModelData! = nil
  
  var isCardDown: Bool = false
  
  var delegate: PitchCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    let frameForView = CGRect.init(x: 0.0,
                                          y: frame.origin.y - (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: frame.size.width,
                                          height: frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight))
    
    super.init(frame: frameForView)
    self.backgroundColor = UIColor.clearColor()
    
    self.createContentView()
    //self.createAddPitchButton()
    
  }
  
  private func createContentView() {
    
    let frameForContentView = CGRect.init(x: 0.0,
                                          y: self.frame.origin.y + (40.0 * UtilityManager.sharedInstance.conversionHeight),
                                      width: self.frame.size.width,
                                     height: self.frame.size.height)
    
    contentView = UIView.init(frame: frameForContentView)
    contentView.backgroundColor = UIColor.clearColor()
    self.addSubview(contentView)
    self.createGestureTap()
    
  }
  
  
  private func createGestureTap() {

    contentView.userInteractionEnabled = true
    
    let tapGestureWhenTap = UITapGestureRecognizer.init(target: self,
                                                        action: #selector(cardPressed))
    tapGestureWhenTap.numberOfTapsRequired = 1
//    tapGestureWhenTap.cancelsTouchesInView = false
    
    contentView.addGestureRecognizer(tapGestureWhenTap)
    
    
    
    //
    
    let downSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(downSwipeCard))
    downSwipe.direction = .Down
    self.addGestureRecognizer(downSwipe)
    
    let upSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(upSwipeCard))
    upSwipe.direction = .Up
    self.addGestureRecognizer(upSwipe)
    
//    let dragAction = UIPanGestureRecognizer.init(target: self, action: #selector(dragCardAction))
//    self.addGestureRecognizer(dragAction)
    
    
  }
  
  @objc private func cardPressed() {
    
    self.delegate?.createAndShowDetailedPitchView()
    
  }
  
  @objc private func downSwipeCard(sender: UISwipeGestureRecognizer) {
    
    if sender.direction == .Down && isCardDown == false {
      
      
      if pitchEvaluationByUserData.pitchStatus == 4 { //already archived
        
        let alertController = UIAlertController(title: "AVISO", message: "Este pitch ya ha sido archivado", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
          
          //Something To Do
          
        }
        
        alertController.addAction(cancelAction)
        self.delegate?.showAlreadyArchivedMessage(alertController)
        
      } else {
      
      
        let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                                 "id": pitchEvaluationByUserData.pitchEvaluationId
                                        ]
      
        self.delegate?.askForArchiveThisPitchCard(params)
      
      
      }
        
    }
    
  }
  
  @objc private func upSwipeCard(sender: UISwipeGestureRecognizer) {
    
    if sender.direction == .Up && isCardDown == true {
      
      self.delegate?.upSwipeDetectedInPitchCard()
      
    }
    
  }
  
  @objc private func dragCardAction(panGesture: UIPanGestureRecognizer) {
    
    //        get translation
    
    let translation = panGesture.translationInView(self)
    panGesture.setTranslation(CGPointZero, inView: self)
    print(translation)
    
    
    //create a new Label and give it the parameters of the old one
    let copyOfCard = panGesture.view as! PitchCardView
    
    if translation.x > 0 {
      
      return
      
    }
    
    if translation.y > 10.0 {
      
      copyOfCard.center = CGPoint(x: copyOfCard.center.x, y: copyOfCard.center.y+translation.y)
      copyOfCard.multipleTouchEnabled = true
      copyOfCard.userInteractionEnabled = true
      
      if panGesture.state == UIGestureRecognizerState.Began {
        
        //add something you want to happen when the Label Panning has started
      }
      
      if panGesture.state == UIGestureRecognizerState.Ended {
        
        //add something you want to happen when the Label Panning has ended
        
      }
      
      
      if panGesture.state == UIGestureRecognizerState.Changed {
        
        //add something you want to happen when the Label Panning has been change ( during the moving/panning )
        
      }
        
      else {
        
        // or something when its not moving
      }
      
    }

  }
  
  
  private func createAddPitchButton() {
    
    let frameForButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: -4.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addPitchButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "buttonAddPitch") as UIImage?
    addPitchButton.setImage(image, forState: .Normal)
    addPitchButton.tag = 1
    addPitchButton.addTarget(self, action: #selector(addPitchButtonPushed), forControlEvents:.TouchUpInside)
    
    self.addSubview(addPitchButton)
    
  }
  
  private func createGraphPart() {
    
    if graphPart != nil {
      
      graphPart.removeFromSuperview()
      graphPart = nil
      
    }
    
    let frameForGraphPart = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var arrayOfQualifications: [Int] = pitchEvaluationByUserData.otherScores
    arrayOfQualifications.insert(pitchEvaluationByUserData.score, atIndex: 0)
    let arrayOfAgencyNames: [String] = [AgencyModel.Data.name]
    
    graphPart = GraphPartPitchCardView.init(frame: frameForGraphPart,
                         newArrayOfQualifications: arrayOfQualifications,
                            newArrayOfAgencyNames: arrayOfAgencyNames)
    
    graphPart.delegate = self
    contentView.addSubview(graphPart)
    //contentView.bringSubviewToFront(addPitchButton)
    
  }
  
  func animateGraph() {
    
    graphPart.animateGraph()
    
  }
  
  func getPitchEvaluationByUserData() -> PitchEvaluationByUserModelData {
    
    return pitchEvaluationByUserData
    
  }
  
  private func createDetailedPart() {
    
    if detailedPart != nil {
      
      detailedPart.removeFromSuperview()
      detailedPart = nil
      
    }
    
    let frameForDetailedPart = CGRect.init(x: 0.0,
                                           y: 347.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 107.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedPart = DetailedPartPitchCardView.init(frame: frameForDetailedPart,
                                          newDateString: pitchEvaluationByUserData.briefDate,
                                         newProjectName: pitchEvaluationByUserData.pitchName,
                                           newBrandName: pitchEvaluationByUserData.brandName,
                                         newCompanyName: pitchEvaluationByUserData.companyName!)
    
    contentView.addSubview(detailedPart)
    
  }
  
  func changePitchData(newPitchByUserData: PitchEvaluationByUserModelData) {
    
    pitchEvaluationByUserData = newPitchByUserData
    self.createGraphPart()
    self.createStatusIcon()
    self.createDetailedPart()
    self.createGestureTap()
    
  }
  
  private func createStatusIcon() {
    
    if pitchEvaluationByUserData.wasWon == false {
      
      thumbsDownIcon = UIImageView.init(image: UIImage.init(named: "thumbsDown"))
      let canceledImageViewFrame = CGRect.init(x:(18.0 * UtilityManager.sharedInstance.conversionWidth  ),
                                               y: (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                               width: thumbsDownIcon.frame.size.width,
                                               height: thumbsDownIcon.frame.size.height)
      thumbsDownIcon.frame = canceledImageViewFrame
      
      contentView.addSubview(thumbsDownIcon)
      
    } else
    
      if pitchEvaluationByUserData.pitchStatus == 1 { //Active
        
        let activeIcon = UIImageView.init(image: UIImage.init(named: "activeStatus"))
        let canceledImageViewFrame = CGRect.init(x:(18.0 * UtilityManager.sharedInstance.conversionWidth  ),
                                                 y: (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                                 width: activeIcon.frame.size.width,
                                                 height: activeIcon.frame.size.height)
        activeIcon.frame = canceledImageViewFrame
        activeIcon.alpha = 0.45
        
        contentView.addSubview(activeIcon)
        
      } else
        
        if pitchEvaluationByUserData.pitchStatus == 2 { //Cancelled
          
          let cancelledIcon = UIImageView.init(image: UIImage.init(named: "cancelledStatus"))
          let canceledImageViewFrame = CGRect.init(x:(18.0 * UtilityManager.sharedInstance.conversionWidth  ),
                                                   y: (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                                   width: cancelledIcon.frame.size.width,
                                                   height: cancelledIcon.frame.size.height)
          cancelledIcon.frame = canceledImageViewFrame
          
          
          contentView.addSubview(cancelledIcon)
          
        } else
          
        if pitchEvaluationByUserData.pitchStatus == 3 { //Declined
            
            let declinedIcon = UIImageView.init(image: UIImage.init(named: "declinedStatus"))
            let canceledImageViewFrame = CGRect.init(x:(18.0 * UtilityManager.sharedInstance.conversionWidth  ),
                                                     y: (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                                     width: declinedIcon.frame.size.width,
                                                     height: declinedIcon.frame.size.height)
            declinedIcon.frame = canceledImageViewFrame
            
            contentView.addSubview(declinedIcon)
            
        } else
            
        if pitchEvaluationByUserData.pitchStatus == 4 { //Archived
              
              let archivedIcon = UIImageView.init(image: UIImage.init(named: "archivedStatus"))
              let canceledImageViewFrame = CGRect.init(x:(18.0 * UtilityManager.sharedInstance.conversionWidth  ),
                                                       y: (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                                       width: archivedIcon.frame.size.width,
                                                       height: archivedIcon.frame.size.height)
              archivedIcon.frame = canceledImageViewFrame
              
              contentView.addSubview(archivedIcon)
              
        }

    
  }
  
  func getGraphPart() -> GraphPartPitchCardView {
    
    return self.graphPart
    
  }
  
  @objc private func addPitchButtonPushed() {
    
    self.delegate?.pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard()
    
  }
  
  //MARK: - GraphPartPitchCardViewDelegate
  
  func showMailToContactAmap(sender: GraphPartPitchCardView) {
    
    self.delegate?.showMailToContactAmapFromPitchCardView(self)
    
  }

}

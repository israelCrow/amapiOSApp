//
//  InfoPitchesViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class InfoPitchesViewController: UIViewController, InfoPitchesViewDelegate, MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate {
  
  private var flipCard: FlipCardView! = nil
  private var infoView: InfoPitchesView! = nil
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    
    self.editNavigationController()
    self.createFlipCard()
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
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
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.navigationBarTitleText,
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
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.InfoPitchesViewAndViewController.rightButtonItemText,
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
  
  private func createFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: widthOfCard,
                                   height: heightOfCard)
    
    let frameForBackAndFrontOfCard = CGRect.init(x: 0.0,
                                                 y: 0.0,
                                                 width: widthOfCard,
                                                 height: heightOfCard)
    
    let blankAndBackView = UIView.init(frame: frameForBackAndFrontOfCard)
    self.createInfoView(frameForBackAndFrontOfCard)
    
    flipCard = FlipCardView.init(frame: frameForCard,
                                 viewOne: infoView,
                                 viewTwo: blankAndBackView)
    
    self.view.addSubview(flipCard)
    
  }
  
  private func createInfoView(frameForInfoView: CGRect) {
    
    infoView = InfoPitchesView.init(frame: frameForInfoView)
    infoView.delegate = self
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 145.0/255.0, green: 242.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 117.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
    self.popMyself()
    
  }
  
  private func popMyself() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }

  func mailIconPressedFromInfoPitchesView() {

    let mailComposeViewController = configuredMailComposeViewController()
    
    if MFMailComposeViewController.canSendMail() {
      
      self.presentViewController(mailComposeViewController, animated: true, completion: nil)
      
    } else {
      
      self.showSendMailErrorAlert()
      
    }
    
   }
  
  func phoneIconPressedFromInfoPtichesView() {
  
    if let url = NSURL(string: "tel://\(VisualizePitchesConstants.InfoPitchesViewAndViewController.phoneLabelText)") {
    
      UIApplication.sharedApplication().openURL(url)
      
    }
    
  }
  
  func webPageIconPressedFronInfoPitchesView() {
    
    let url = NSURL.init(string: "http://\(VisualizePitchesConstants.InfoPitchesViewAndViewController.webSiteLabelText)")
    
    let safariExplorer = SFSafariViewController.init(URL: url!)
    safariExplorer.delegate = self
    
    self.navigationController?.presentViewController(safariExplorer, animated: true, completion: nil)
    
  }
  
  func configuredMailComposeViewController() -> MFMailComposeViewController {
    
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    
    mailComposerVC.setToRecipients([VisualizePitchesConstants.InfoPitchesViewAndViewController.mailLabelText])
    mailComposerVC.setSubject("Contactar a AMAP desde Happitch :)")
    mailComposerVC.setMessageBody("", isHTML: false)
    
    return mailComposerVC
    
  }
  
  func showSendMailErrorAlert() {
    
    let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
    }
    
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  
}



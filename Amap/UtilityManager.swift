//
//  UtilityManager.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Foundation

class UtilityManager: NSObject {
  
  static let sharedInstance = UtilityManager()
  
  let apiToken = "Token 732f80decfc02b204a53e2480e5b7ec5" //DEVELOPMENT "Token 40e97aa81c2be2de4b99f1c243bec9c4" //PRODUCTION "Token 732f80decfc02b204a53e2480e5b7ec5"
  let kLastValidUserEmail = "kLastValidUserEmail"
  let kLastValidUserPassword =  "kLastValidUserPassword"
  let kNotToShowProfileTutorial = "kNotToShowProfileTutorial"
  let kNotToShowPitchesTutorial = "kNotToShowPitchesTutorial"
  let kNotToShowDashboardTutorial = "kNotToShowDashboardTutorial"
  let kSavedPhotoAndSavedName = "kSavedPhotoAndSavedName"
  
  let kDocuments = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
  let kcache = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) [0]
  
  static let baseScreen = CGSize.init(width: 375.0, height: 667.0)
  static let screenSize = CGSize.init(width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
  static let frameOfConversion = CGSize.init(width: screenSize.height/baseScreen.height, height: screenSize.width/baseScreen.width)
  
  let conversionWidth = frameOfConversion.width
  let conversionHeight = frameOfConversion.height
  
  let arrayOfImagesForLoader: [UIImage] = [UIImage.init(named: "loader_1")!,
                                            UIImage.init(named: "loader_2")!,
                                            UIImage.init(named: "loader_3")!,
                                            UIImage.init(named: "loader_4")!,
                                            UIImage.init(named: "loader_5")!,
                                            UIImage.init(named: "loader_6")!,
                                            UIImage.init(named: "loader_7")!,
                                            UIImage.init(named: "loader_8")!,
                                            UIImage.init(named: "loader_9")!,
                                            UIImage.init(named: "loader_10")!,
                                            UIImage.init(named: "loader_11")!,
                                            UIImage.init(named: "loader_12")!,
                                            UIImage.init(named: "loader_13")!,
                                            UIImage.init(named: "loader_14")!,
                                            UIImage.init(named: "loader_15")!,
                                            UIImage.init(named: "loader_16")!,
                                            UIImage.init(named: "loader_17")!,
                                            UIImage.init(named: "loader_18")!,
                                            UIImage.init(named: "loader_19")!,
                                            UIImage.init(named: "loader_20")!,
                                            UIImage.init(named: "loader_21")!,
                                            UIImage.init(named: "loader_22")!,
                                            UIImage.init(named: "loader_23")!,
                                            UIImage.init(named: "loader_24")!,
                                            UIImage.init(named: "loader_25")!,
                                            UIImage.init(named: "loader_26")!,
                                            UIImage.init(named: "loader_27")!,
                                            UIImage.init(named: "loader_28")!,
                                            UIImage.init(named: "loader_29")!,
                                            UIImage.init(named: "loader_30")!,
                                            UIImage.init(named: "loader_31")!,
                                            UIImage.init(named: "loader_32")!,
                                            UIImage.init(named: "loader_33")!,
                                            UIImage.init(named: "loader_34")!,
                                            UIImage.init(named: "loader_35")!,
                                            UIImage.init(named: "loader_36")!,
                                            UIImage.init(named: "loader_37")!]
  var loaderImageView: UIImageView! = nil
  private var requestToLoader = 0
  var loadingView: UIView! = nil
  var mainTabBarController: UITabBarController! = nil
  
  func getFrontViewController() -> UIViewController? {
    
    if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
    
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      
      return topController
    }
    
    return nil
    
  }
  
  func currentViewController () -> UIViewController {
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let currentViewController: UIViewController = appDelegate.window!.rootViewController!
    return currentViewController
  }
  
  func showLoader() {
    
    if loadingView == nil {
      loadingView = UIView.init(frame: UIScreen.mainScreen().bounds)
      loadingView.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
      
      let frameForImageView = CGRect.init(x: (loadingView.frame.size.width / 2.0) - (75.0 * conversionWidth) ,
                                          y: (loadingView.frame.size.height / 2.0) - (75.0 * conversionHeight),
                                      width: 150.0 * conversionWidth,
                                     height: 150.0 * conversionHeight)
      
      loaderImageView = UIImageView.init(frame: frameForImageView)
      loaderImageView.backgroundColor = UIColor.clearColor()
      loaderImageView.animationImages = arrayOfImagesForLoader
      loadingView.alpha = 0.0
      loadingView.addSubview(loaderImageView)
      
    }
    
    if requestToLoader == 0 {
    
      let rootViewController = self.currentViewController()
      rootViewController.view.addSubview(loadingView)
      loaderImageView.animationDuration = 1.0
      loaderImageView.animationRepeatCount = 0
      loaderImageView.startAnimating()
    
      UIView.animateWithDuration(0.35){
      
      self.loadingView.alpha = 1.0
      
      }
      
    }
    
    requestToLoader += 1
    
    print("Show loader \(requestToLoader)")
    
  }
  
  func hideLoader() {
    
    requestToLoader -= 1
    
    print("Hide loader \(requestToLoader)")
    
    if requestToLoader == 0 {
    
      if loadingView != nil {
      
        UIView.animateWithDuration(0.35, animations: {
        
          self.loadingView.alpha = 0.0
        
        }, completion: { (finished) in
            if finished == true {
            
              self.loaderImageView.stopAnimating()
            
            }
        })
      
      }
    
    }
    
    if requestToLoader < 0 {
      
      requestToLoader = 0
      
    }
  
  }
  
  func getRatioOfScreen() -> Double {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let ratio = Double(screenWidth) / 187.5
    return ratio
    
  }
  
  func frameWithRatio(rectToChange: CGRect) -> CGRect {
    
    return CGRectZero
    
  }
  
  func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
    
  }
  
  //return true when there are not blanks
  func isValidText(testString: String) -> Bool {
    
    let whiteSpace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
    let trimmed = testString.stringByTrimmingCharactersInSet(whiteSpace)
    
    if trimmed.characters.count != 0 {
      
      return true
      
    }else{
      
      return false
      
    }
    
  }
  
  func validateIfLinkIsYoutube(url: String?) -> Bool {
    
    if url != nil && url != "" {

      let path = NSURL.fileURLWithPath(url!)
      if path.pathComponents?.count >= 3 {
        
        let host = path.pathComponents![2]
      
        if host == "m.youtube.com" || host == "youtube" || host == "youtu.be" || host == "youtube.com" || host == "www.youtube.com" {
          
          return true
          
        } else {
          
          return false
          
        }
        
      }else{
        
        return false
        
      }
      
    } else {
      
      return false
      
    }
    
  }
  
  func validateIfLinkIsVimeo(url: String?) -> Bool {
    
    if url != nil && url != "" {
      
      let path = NSURL.fileURLWithPath(url!)
      if path.pathComponents?.count >= 3 {
        
        let host = path.pathComponents![2]
        
        if host == "vimeo" || host == "vimeo.com" || host == "www.vimeo.com" {
          
          return true
          
        } else {
          
          return false
          
        }
        
      }else{
        
        return false
        
      }
      
    } else {
      
      return false
      
    }
    
  }
  
  func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 5.0)
//    UIGraphicsBeginImageContext(CGSizeMake(newSize.width, newSize.height))
    image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
    
  }
  
}

private let minimumHitArea = CGSizeMake(44, 44)

extension UIButton {
  public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    // if the button is hidden/disabled/transparent it can't be hit
    if self.hidden || !self.userInteractionEnabled || self.alpha < 0.01 { return nil }
    
    // increase the hit frame to be at least as big as `minimumHitArea`
    let buttonSize = self.bounds.size
    let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
    let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
    let largerFrame = CGRectInset(self.bounds, -widthToAdd / 2, -heightToAdd / 2)
    
    // perform hit test on larger frame
    return (CGRectContainsPoint(largerFrame, point)) ? self : nil
  }
}


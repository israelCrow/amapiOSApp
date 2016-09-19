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
  
  let apiToken = "Token 40e97aa81c2be2de4b99f1c243bec9c4"
  
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
  var loadingView: UIView! = nil
  
  
//  func currentViewController() -> UIViewController {
//    
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let currentViewController: UIViewController = appDelegate.window!.rootViewController!
//    return currentViewController
//    
//  }
  
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
    
    let rootViewController = self.currentViewController()
    rootViewController.view.addSubview(loadingView)
    loaderImageView.animationDuration = 1.2
    loaderImageView.animationRepeatCount = 0
    loaderImageView.startAnimating()
    
    UIView.animateWithDuration(0.35){
      
      self.loadingView.alpha = 1.0
      
    }
    
  }
  
  func hideLoader() {
    
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
    
    if url != nil {

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
    
    if url != nil {
      
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
    
    UIGraphicsBeginImageContext(CGSizeMake(newSize.width, newSize.height))
    image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
//  func showIndicatorWithText(text: String) {
//    if self.loadingView == nil {
//      self.loadingView = UIView(frame: self.currentViewController().view.frame)
//      self.loadingView.backgroundColor = UIColor.clearColor()
//    }
//    
//    loadingView.addSubview(SwiftSpinner.show(text))
//    self.loadingView.alpha = 1.0
//    
//    self.currentViewController().view.addSubview (loadingView)
//    self.currentViewController().view.bringSubviewToFront(loadingView)
//  }
//  
//  func hideIndicator() {
//    if self.loadingView != nil {
//      UIView.animateWithDuration(0.25,
//                                 animations: {
//                                  self.loadingView.alpha = 0.0
//        },
//                                 completion: { finished in
//                                  self.loadingView.removeFromSuperview()
//                                  SwiftSpinner.hide()
//        }
//      )
//    }
//  }
}
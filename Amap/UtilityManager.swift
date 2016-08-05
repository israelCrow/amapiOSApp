//
//  UtilityManager.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class UtilityManager: NSObject {
  
  static let sharedInstance = UtilityManager()
  
  
  static let baseScreen = CGSize.init(width: 365.0, height: 667.0)
  static let screenSize = CGSize.init(width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
  static let frameOfConversion = CGSize.init(width: screenSize.height/baseScreen.height, height: screenSize.width/baseScreen.width)
  
  let conversionWidth = frameOfConversion.width
  let conversionHeight = frameOfConversion.height
  var loadingView: UIView!
  
//  func currentViewController() -> UIViewController {
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    let currentViewController: UIViewController = appDelegate.window!.rootViewController!
//    return currentViewController
//  }
  
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
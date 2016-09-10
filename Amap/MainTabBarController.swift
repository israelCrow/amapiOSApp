//
//  MainTabBarController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, VisualizeAgencyProfileViewControllerDelegate, VisualizeAllPitchesViewControllerShowAndHideDelegate {
  
  var isShownTabBar: Bool = true
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    
  }
  
  private func hideTabBar() {
    
    if isShownTabBar ==  true {
      
      let newFrameForTabBar = CGRect.init(x: tabBar.frame.origin.x,
                                          y: tabBar.frame.origin.y + tabBar.frame.size.height,
                                          width: tabBar.frame.size.width,
                                          height: tabBar.frame.size.height)
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  self.tabBar.frame = newFrameForTabBar
                                  
        }, completion: { (finished) in
          if finished ==  true {
            self.isShownTabBar = false
          }
      })
      
    }
    
  }
  
  private func showTabBar() {
    
    if isShownTabBar ==  false {
      
      let newFrameForTabBar = CGRect.init(x: tabBar.frame.origin.x,
                                          y: tabBar.frame.origin.y - tabBar.frame.size.height,
                                          width: tabBar.frame.size.width,
                                          height: tabBar.frame.size.height)
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  self.tabBar.frame = newFrameForTabBar
                                  
        }, completion: { (finished) in
          if finished ==  true {
            self.isShownTabBar = true
          }
      })
      
    }
    
  }
  
  func requestToHideTabBarFromVisualizeAgencyProfileViewControllerDelegate() {
    
    self.hideTabBar()
    
  }
  
  func requestToShowTabBarFromVisualizeAgencyProfileViewControllerDelegate() {
    
    self.showTabBar()
    
  }
  
  func requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate() {
    
    self.hideTabBar()
    
  }
  
  func requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate() {
    
    self.showTabBar()
    
  }

  override func didReceiveMemoryWarning() {
    
  }
  
  
  
  
}

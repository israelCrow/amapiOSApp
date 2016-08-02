//
//  SplashViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
  
  override func loadView() {
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
  }
  
  override func viewDidLoad() {
    self.navigationController?.navigationBarHidden = true
    self.navigationController?.navigationBar.barStyle = .Black
    
    //Check whether there has already been a coonection
    
    //If there's not info show tutorial
    self.showLogin()
  }
  
  private func showLogin() {
    let loginViewController = LoginViewController()
    self.navigationController?.pushViewController(loginViewController, animated: true)
    
//    let tutorialViewController = TutorialViewController()
//    self.navigationController?.pushViewController(tutorialViewController, animated: true)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func didReceiveMemoryWarning() {
    
  }
  
}
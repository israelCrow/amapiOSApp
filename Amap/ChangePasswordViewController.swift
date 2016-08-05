//
//  ChangePasswordViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
  
  let kCreateAccount = "Crear Cuenta"
  
  override func loadView() {
    self.editNavigationBar()
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.view.addSubview(self.createGradientView())
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    
  }
  
  private func changeBackButtonItem() {
    let imageBackButton = UIImage.init(named: "backButton")
    let backButton = UIBarButtonItem.init(image: imageBackButton,
                                          style: .Plain,
                                          target: self,
                                          action: #selector(backButtonPressed)
    )
    self.navigationItem.setLeftBarButtonItem(backButton, animated: false)
  }
  
  private func changeNavigationBarTitle() {
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular", size: 17.0)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: kCreateAccount,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  override func viewDidLoad() {
    
    let frameForViewCard = CGRect.init(x: 40.0, y: 100.0, width: self.view.frame.width - 80.0, height: self.view.frame.height - 116.0 - 60)
    
    let changePassView = ChangePasswordRequestView.init(frame: frameForViewCard)
    self.view.addSubview(changePassView)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 145.0/255.0, green: 255.0/255.0, blue: 171.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 244.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func didReceiveMemoryWarning() {
    
  }
  
  @objc private func backButtonPressed() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  
}
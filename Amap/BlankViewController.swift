//
//  BlankViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class BlankViewController: UIViewController {
  
  override func loadView() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.changeNavigationBarTitle()
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
  }
  
  private func changeNavigationBarTitle() {
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "PRUEBA INFO",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.whiteColor()
  }

}

//
//  GoldenPitchLoginView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GoldenPitchLoginView: UIView {
  
  private var goldenPitchStarImageVew: UIImageView! = nil
  
  private var goldenPitchLabel: UILabel! = nil
  private var amapLabel: UILabel! = nil
  private var writeNameDescriptionLabel: UILabel! = nil
  private var nameLabel: UILabel! = nil
  private var writeEMailDescription: UILabel! = nil
  private var forgotPassword: UILabel! = nil
  
  private var nameTextField: UITextField! = nil
  private var eMailTextField: UITextField! = nil
  
  private var cancelButtonForNameTextField: UIButton! = nil
  private var cancelButtonForEMailTextField: UIButton! = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}



//
//  FlipCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class FlipCardView: UIView{
  
  private var viewOne: UIView
  private var viewTwo: UIView
  private var showingBack = false
  
//  var bottomButtonFirstView: UIButton = {
//    let button = UIButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
//    button.backgroundColor = UIColor.blackColor()
//    button.titleLabel?.text = "Button 1"
//    return button
//  }()
//  
//  var bottomButtonSecondView: UIButton = {
//    let button = UIButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
//    button.backgroundColor = UIColor.blackColor()
//    button.titleLabel?.text = "Button 2"
//    return button
//  }()

  
  init(frame: CGRect, viewOne: UIView, viewTwo: UIView) {
    self.viewOne = viewOne
    self.viewTwo = viewTwo
    super.init(frame: frame)
    self.adaptInterface()
  }
  
  private func adaptInterface() {
    //self.viewTwo.addSubview(self.bottomButton)
    
//    self.addButtons()
    self.viewTwo.hidden = true
    self.addSubview(self.viewOne)
    self.addSubview(self.viewTwo)
//
    self.adaptMyself()
  }
  
//  private func addButtons(){
//    let frameForButtons = CGRect.init(x:0.0, y: self.viewOne.frame.size.height - 70.0, width: self.viewOne.frame.size.width, height: 70.0)
//    
//    self.bottomButtonFirstView.frame = frameForButtons
//    self.bottomButtonSecondView.frame = frameForButtons
//    
//    self.viewOne.addSubview(self.bottomButtonFirstView)
//    self.viewTwo.addSubview(self.bottomButtonSecondView)
//  }
  
  private func adaptMyself() {
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 0.25
    self.layer.shadowOffset = CGSizeZero
    self.layer.shadowRadius = 5
  }
  
  @objc func flip() {
    self.viewTwo.hidden = false
    self.viewOne.hidden = true
    UIView.transitionFromView(self.viewOne,
                              toView: self.viewTwo,
                            duration: 0.5,
                             options: .TransitionFlipFromLeft) { (finished) in
                                if finished {
                                  self.showingBack = true
                                }
                              }
  }
  
  func setSecondView(newSecondView: UIView) {
    newSecondView.hidden = true
    self.viewTwo = newSecondView
  }

//  @objc private func buttonViewOneTapped() {
//    self.delegate?.bottomButtonOfFirstViewOfCardTapped()
//  }
//  
//  @objc private func buttonViewTwoTapped() {
//    self.delegate?.bottomButtonOfSecondViewOfCardTapped()
//  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}

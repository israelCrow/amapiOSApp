//
//  LoginViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FlipCardViewDelegate {
  
  private var flipCard:FlipCardView! = nil
  
  override func loadView() {
    self.view = self.createGradientView()
  }

  override func viewDidLoad() {
    
    self.createFlipCardView()
  
  }
  
  private func createFlipCardView() {
    let colorsOne = [UIColor.redColor(), UIColor.blueColor()]
    let colorsTwo = [UIColor.blueColor(), UIColor.redColor()]
    
    let widthOfCard = self.view.frame.size.width - 80.0
    let heightOfCard = self.view.frame.size.height - 136.0
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    let frameForCard = CGRect.init(x: 40.0, y: 60.0, width: widthOfCard, height: heightOfCard)
    
    let viewGradientOne = GradientView.init(frame: frameForViewsOfCard, arrayOfcolors: colorsOne, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    let viewGradientTwo = GradientView.init(frame: frameForViewsOfCard, arrayOfcolors: colorsTwo, typeOfInclination: GradientView.TypeOfInclination.rightToLeftInclination)
    
    flipCard = FlipCardView.init(frame: frameForCard, viewOne: viewGradientOne, viewTwo: viewGradientTwo)
    flipCard.delegate = self
    
    self.view.addSubview(flipCard)
  }
  
  private func createGradientView() -> GradientView{
    
    let firstColorGradient = UIColor.init(red: 135.0/255.0, green: 255.0/255.0, blue: 161.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 106.0/255.0, green: 241.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    return GradientView.init(frame: UIScreen.mainScreen().bounds, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func didReceiveMemoryWarning() {
  }
  
  //MARK - FlipCardViewDelegate
  func bottomButtonOfFirstViewOfCardTapped() {
    flipCard.flip()
  }
  
  func bottomButtonOfSecondViewOfCardTapped() {
    flipCard.flip()
  }
  
  
  
}

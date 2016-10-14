//
//  DetailPitchSkillsEvaluationView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DetailPitchSkillsEvaluationView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  
  private var pitchSkillsLabel: UILabel! = nil
  private var mainCollectionView: UICollectionView! = nil
  private var arrayOfEvaluationPitchSkillCategories: [EvaluationPitchSkillCategoryModelData]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfEvaluationPitchSkillCategories: [EvaluationPitchSkillCategoryModelData]) {
    
    arrayOfEvaluationPitchSkillCategories = newArrayOfEvaluationPitchSkillCategories
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    self.createPitchSkillsLabel()
    self.createMainCollectionView()
    
  }
  
  private func createPitchSkillsLabel() {
    
    pitchSkillsLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DetailPitchSkillsEvaluationView.skillsEvaluationLabel,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
        NSKernAttributeName: CGFloat(2.0)
      ]
    )
    pitchSkillsLabel.attributedText = stringWithFormat
    pitchSkillsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (pitchSkillsLabel.frame.size.width / 2.0),
                               y: 0.0,
                               width: pitchSkillsLabel.frame.size.width,
                               height: pitchSkillsLabel.frame.size.height)
    
    pitchSkillsLabel.frame = newFrame
    
    self.addSubview(pitchSkillsLabel)
    
  }
  
  private func createMainCollectionView() {
    
    let sizeOfItems = CGSize(width: 75.0 * UtilityManager.sharedInstance.conversionWidth,
                             height: 75.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForMainCollectionView = CGRect.init(x: 0.0,
                                                 y: 50.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                            height: 85.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let constantOfInset = 5.0 * UtilityManager.sharedInstance.conversionWidth
    layout.sectionInset = UIEdgeInsets(top: constantOfInset,
                                      left: constantOfInset,
                                    bottom: constantOfInset,
                                     right: constantOfInset)
    layout.itemSize = sizeOfItems
    
    mainCollectionView = UICollectionView(frame: frameForMainCollectionView,
                                          collectionViewLayout: layout)
    mainCollectionView.dataSource = self
    mainCollectionView.delegate = self
    mainCollectionView.registerClass(SkillEvaluationCell.self ,forCellWithReuseIdentifier: "Cell")
    mainCollectionView.backgroundColor = UIColor.clearColor()
    self.addSubview(mainCollectionView)
    
    
    //Creation of the separation line
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (1.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 1.0)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = false
    
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfEvaluationPitchSkillCategories.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SkillEvaluationCell
    
    cell.createIconCell()
    cell.setEvaluationPitchSkillCategoryData(arrayOfEvaluationPitchSkillCategories[indexPath.row])
    
    return cell
    
  }
  
  func setArrayOfEvaluationPitchSkillCategories(newArray: [EvaluationPitchSkillCategoryModelData]) {
  
    arrayOfEvaluationPitchSkillCategories = newArray
    mainCollectionView.reloadData()
  
  }
  
  
}

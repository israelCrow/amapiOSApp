//
//  CreateCaseView.swift
//  Amap
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateCaseViewDelegate {
  
  func createCaseRequest(parameters: [String:AnyObject])
  func cancelCreateCase()
  func selectImageCaseFromLibrary()
  
  
}

class CreateCaseView: UIView, UITextFieldDelegate, UITextViewDelegate, VideoPlayerVimeoYoutubeViewDelegate{
  
  private var cancelCreateButton: UIButton! = nil
  private var saveCaseButton: UIButton! = nil
  private var mainScrollView: UIScrollView! = nil
  private var caseImage: UIImage?
  private var caseNameView: CustomTextFieldWithTitleView! = nil
  private var caseDescriptionTextView: UITextView! = nil
  private var clearButton: UIButton! = nil
  private var addImageLabel: UILabel! = nil
  private var caseImageView: UIImageView! = nil
  private var changeCaseImageButton: UIButton! = nil
  private var caseVideoPlayerVimeoYoutube: VideoPlayerVimeoYoutubeView! = nil
  private var previewVideoPlayerVimeoYoutube: PreviewVimeoYoutubeView! = nil
  private var caseWebLinkView: CustomTextFieldWithTitleView! = nil
  private var errorInFieldsLabel: UILabel! = nil
  
  private var caseDataForPreview: Case! = nil
  
  var delegate: CreateCaseViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.addSomeGestures()
    self.initInterface()
    
  }
  
  init(frame: CGRect, caseData: Case){
  
    caseDataForPreview = caseData
    
    super.init(frame: frame)
  
    self.addSomeGestures()
    self.initInterfaceForPreview()
  
  }
  
  private func addSomeGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.userInteractionEnabled = true
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCancelCreateButton()
    self.createSaveCaseButton()
    self.createMainScrollView()
    self.createCaseNameView()
    self.createCaseDescriptionTextView()
    self.createAddImageLabel()
    self.createCaseVideoPlayerVimeoYoutubeWithoutURL()
    self.createCaseWebLinkView()
    self.createErrorInFieldsLabel()
  }
  
  private func initInterfaceForPreview() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCancelCreateButton()
    self.createMainScrollView()
    self.createCaseNameViewForPreview()
    self.createCaseDescriptionTextViewForPreview()
    self.createAddImageLabelForPreview()
    self.createPreviewVideoPlayerVimeoYoutube()
    self.createCaseWebLinkViewForPreview()
    
  }
  
  private func createCancelCreateButton() {
    
    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 20.0 * UtilityManager.sharedInstance.conversionWidth ,
                                height: 20.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelCreateButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "deleteButton") as UIImage?
    cancelCreateButton.setImage(image, forState: .Normal)
    cancelCreateButton.alpha = 1.0
    cancelCreateButton.addTarget(self, action: #selector(cancelCreateCase), forControlEvents:.TouchUpInside)
    
    self.addSubview(cancelCreateButton)
    
  }
  
  private func createSaveCaseButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringForSaveButton = "Crea caso"
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringForSaveButton ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: stringForSaveButton,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight), width: self.frame.size.width, height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    saveCaseButton = UIButton.init(frame: frameForButton)
    saveCaseButton.addTarget(self,
                         action: #selector(requestCreateCase),
                         forControlEvents: .TouchUpInside)
    saveCaseButton.backgroundColor = UIColor.blackColor()
    saveCaseButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveCaseButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(saveCaseButton)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 421.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.whiteColor()
    self.addSubview(mainScrollView)
    
  }
  
  private func createCaseNameView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    caseNameView.mainTextField.placeholder = "Nombre del caso"
    caseNameView.backgroundColor = UIColor.clearColor()
    caseNameView.mainTextField.delegate = self
    self.mainScrollView.addSubview(caseNameView)
    
  }
  
  private func createCaseNameViewForPreview() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    caseNameView.mainTextField.text = caseDataForPreview.caseName
    caseNameView.mainTextField.userInteractionEnabled = false
    caseNameView.backgroundColor = UIColor.clearColor()
    caseNameView.mainTextField.delegate = self
    self.mainScrollView.addSubview(caseNameView)
    
  }
  
  private func createCaseDescriptionTextView() {
    
    let frameForTextView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 57.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 82.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseDescriptionTextView = UITextView.init(frame: frameForTextView)
    caseDescriptionTextView.tag = 1
    caseDescriptionTextView.backgroundColor = UIColor.whiteColor()
    caseDescriptionTextView.font = UIFont(name:"SFUIText-Regular",
                                        size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    caseDescriptionTextView.text = "Descripción del caso"
    caseDescriptionTextView.textColor = UIColor.lightGrayColor()
    caseDescriptionTextView.delegate = self

    self.mainScrollView.addSubview(caseDescriptionTextView)
    
    self.createCancelButtonForNameTextView()
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 0.5)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = true
    
   
    
  }
  
  private func createCaseDescriptionTextViewForPreview() {
    
    let frameForTextView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 57.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 82.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseDescriptionTextView = UITextView.init(frame: frameForTextView)
    caseDescriptionTextView.tag = 1
    caseDescriptionTextView.backgroundColor = UIColor.whiteColor()
    caseDescriptionTextView.font = UIFont(name:"SFUIText-Regular",
                                          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    caseDescriptionTextView.text = caseDataForPreview.caseDescription
    caseDescriptionTextView.userInteractionEnabled = false
    caseDescriptionTextView.textColor = UIColor.blackColor()
    caseDescriptionTextView.delegate = self
    
    self.mainScrollView.addSubview(caseDescriptionTextView)
    
    self.createCancelButtonForNameTextView()
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 0.5)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = true

  }
  
  private func createCancelButtonForNameTextView() {
    let frameForButton = CGRect.init(x:caseDescriptionTextView.frame.origin.x + caseDescriptionTextView.frame.size.width - (20.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: caseDescriptionTextView.frame.origin.y,
                                     width: 20.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 20.0 * UtilityManager.sharedInstance.conversionHeight)
    clearButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "deleteButton") as UIImage?
    clearButton.setImage(image, forState: .Normal)
    clearButton.tag = 1
    clearButton.alpha = 0.0
    clearButton.addTarget(self, action: #selector(deleteNameTextView), forControlEvents:.TouchUpInside)
    
    caseDescriptionTextView.addSubview(clearButton)
  }
  
  private func createAddImageLabel() {
    
    addImageLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CreateCaseView.caseAddImageLabelText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    addImageLabel.attributedText = stringWithFormat
    addImageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (160 * UtilityManager.sharedInstance.conversionHeight),
                               width: addImageLabel.frame.size.width,
                               height: addImageLabel.frame.size.height)
    
    addImageLabel.frame = newFrame
    
    self.mainScrollView.addSubview(addImageLabel)
    
  }
  
  private func createAddImageLabelForPreview() {
    
    addImageLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Imagen/Video del caso",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    addImageLabel.attributedText = stringWithFormat
    addImageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (160 * UtilityManager.sharedInstance.conversionHeight),
                               width: addImageLabel.frame.size.width,
                               height: addImageLabel.frame.size.height)
    
    addImageLabel.frame = newFrame
    
    self.mainScrollView.addSubview(addImageLabel)
    
  }
  
  private func createCaseImageView() {
    
    let frameForCaseImageView = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseImageView = UIImageView.init(frame: frameForCaseImageView)
    caseImageView.backgroundColor = UIColor.redColor()
    caseImageView.layer.masksToBounds = false
    
    mainScrollView.addSubview(caseImageView)
    
  }

  private func createCaseWebLinkView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 322.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseWebLinkView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.CreateCaseView.caseWebLinkLabelText,
                                                        image: nil)
    caseWebLinkView.mainTextField.placeholder = "www.ejemplo.com"
    caseWebLinkView.backgroundColor = UIColor.clearColor()
    caseWebLinkView.mainTextField.delegate = self
    caseWebLinkView.mainTextField.tag = 8
    self.mainScrollView.addSubview(caseWebLinkView)
    
  }
  
  private func createCaseWebLinkViewForPreview() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 322.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseWebLinkView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: "Link del caso",
                                                        image: nil)
    caseWebLinkView.mainTextField.text = caseDataForPreview.caseWebLink
    caseWebLinkView.mainTextField.userInteractionEnabled = false
    caseWebLinkView.backgroundColor = UIColor.clearColor()
    caseWebLinkView.mainTextField.delegate = self
    caseWebLinkView.mainTextField.tag = 8
    self.mainScrollView.addSubview(caseWebLinkView)
    
  }

  
  private func createErrorInFieldsLabel() {
    
    errorInFieldsLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Nombre, descripción, imagen o link obligatorios",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorInFieldsLabel.attributedText = stringWithFormat
    errorInFieldsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (errorInFieldsLabel.frame.size.width / 2.0),
                               y: 435.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: errorInFieldsLabel.frame.size.width,
                          height: errorInFieldsLabel.frame.size.height)
    
    errorInFieldsLabel.frame = newFrame
    errorInFieldsLabel.alpha = 0.0
    self.addSubview(errorInFieldsLabel)
    
  }
  
  //Called at the beggining or without text
  private func createCaseVideoPlayerVimeoYoutubeWithoutURL() {
    
    if caseVideoPlayerVimeoYoutube != nil {
      
      caseVideoPlayerVimeoYoutube.layer.removeAllAnimations()
      caseVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
      caseVideoPlayerVimeoYoutube = nil
      
    }
    
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: frameForVideoPlayer, url: nil)
    caseVideoPlayerVimeoYoutube.delegate = self
    self.mainScrollView.addSubview(caseVideoPlayerVimeoYoutube)
    
    
  }
  
  
  
  //Called when user writes down the case web link
  
  private func createCaseVideoPlayerVimeoYoutube(url: String) {
    
    if caseVideoPlayerVimeoYoutube != nil {
      
      caseVideoPlayerVimeoYoutube.layer.removeAllAnimations()
      caseVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
      caseVideoPlayerVimeoYoutube = nil
      
    }
    
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                      width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseVideoPlayerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: frameForVideoPlayer, url: url)
    caseVideoPlayerVimeoYoutube.delegate = self
    self.mainScrollView.addSubview(caseVideoPlayerVimeoYoutube)
    
  }
  
  private func createPreviewVideoPlayerVimeoYoutube() {
    
    if previewVideoPlayerVimeoYoutube != nil {
      
      previewVideoPlayerVimeoYoutube.layer.removeAllAnimations()
      previewVideoPlayerVimeoYoutube.layer.removeFromSuperlayer()
      previewVideoPlayerVimeoYoutube = nil
      
    }
    
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: addImageLabel.frame.origin.y + addImageLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    previewVideoPlayerVimeoYoutube = PreviewVimeoYoutubeView.init(frame: frameForVideoPlayer,
                                                               caseInfo: caseDataForPreview)
    
    self.mainScrollView.addSubview(previewVideoPlayerVimeoYoutube)
    
  }
  
  
  
  func changeCaseImageView(newImage: UIImage) {
    
    caseImage = newImage
    self.caseVideoPlayerVimeoYoutube.changeImageOfCase(newImage)
    
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {

    
    if textField.tag == 8 {
      
      let textChecked = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      
      if textChecked != nil && textChecked != "" {
        
        createCaseVideoPlayerVimeoYoutube(textChecked!)
        
      } else {
        
        createCaseVideoPlayerVimeoYoutubeWithoutURL()
        
      }
      
    }
    
    return true
  }
  
  private func showErrorInFieldsLabel() {
  
    if errorInFieldsLabel.alpha == 0.0 {
      UIView.animateWithDuration(0.35){
        self.errorInFieldsLabel.alpha = 1.0
      }
    }
  
  }
  
  private func hideErrorInFieldsLabel() {
    
    if errorInFieldsLabel.alpha == 1.0 {
      UIView.animateWithDuration(0.35){
        self.errorInFieldsLabel.alpha = 0.0
      }
    }
    
  }
  
  private func showClearButton() {
    
    if clearButton.alpha == 0.0 {
      UIView.animateWithDuration(0.35){
        self.clearButton.alpha = 1.0
      }
    }
    
  }
  
  private func hideClearButton() {
    
    if clearButton.alpha == 1.0 {
      UIView.animateWithDuration(0.35){
        self.clearButton.alpha = 0.0
      }
    }
    
  }
  
  @objc private func deleteNameTextView() {
    
    caseDescriptionTextView.text = ""
    self.hideClearButton()
    
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    self.hideErrorInFieldsLabel()
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    
    self.hideErrorInFieldsLabel()
    
    if textView.tag == 1 {
      
      self.removePlaceHolderOfTextView(textView)
      self.showClearButton()
      
    }
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    if textView.tag == 1 {
      
      self.setPlaceHolderOfTextView(textView)
      if textView.text != "Descripción del caso" {
      
        self.showClearButton()
        
      }
    }
  }
  
  func textViewDidChange(textView: UITextView) {
    
    if textView.tag == 1 {
      
      self.showClearButton()
      
    }
    
  }
  
  private func removePlaceHolderOfTextView(textView: UITextView) {
    
    if textView.text == "Descripción del caso" {
      
      textView.text = ""
      textView.textColor = UIColor.blackColor()
      
    }
  }
  
  private func setPlaceHolderOfTextView(textView: UITextView) {
   
    if textView.text == "" {
      
      textView.text = "Descripción del caso"
      textView.textColor = UIColor.lightGrayColor()
      self.hideClearButton()
      
    }
    
  }
  
  @objc private func cancelCreateCase() {
   
    self.delegate?.cancelCreateCase()
    
  }
  
  @objc private func requestCreateCase() {
    
    let isNameOk = UtilityManager.sharedInstance.isValidText(caseNameView.mainTextField.text!)
    let isDescriptionOk = UtilityManager.sharedInstance.isValidText(caseDescriptionTextView.description)
    let isURLOk = UtilityManager.sharedInstance.isValidText(caseWebLinkView.mainTextField.text!)
    let doesExistImage: Bool
    if caseImage != nil {
      doesExistImage = true
    }else{
      doesExistImage = false
    }
    
    if (isNameOk == true && isDescriptionOk == true && isURLOk == true)
                                      ||
      (isNameOk == true && isDescriptionOk == true && doesExistImage == true) {
      
      var params = [String:AnyObject]()
      let caseName: String = caseNameView.mainTextField.text!
      let caseDescription: String = caseDescriptionTextView.text
      let caseWebLink: String = caseWebLinkView.mainTextField.text!
      
      if doesExistImage ==  false {

        params = [
          "auth_token" : "pqTrEetLEJT_vT1fsVzU",//request for it
          "filename" : "AgenciaPrueba1.png", //Change this in future
          "success_case" :
                           ["name" : caseName,
                     "description" : caseDescription,
                             "url" : caseWebLink,
                       "agency_id" : 1  //Change this in future
                           ]
        ]
      }else{
        
        let dataImage = UIImagePNGRepresentation(caseImage!)
        
        params = [
          "auth_token" : "pqTrEetLEJT_vT1fsVzU",//request for it
          "filename" : "AgenciaPrueba1.png", //Change this in future
          "success_case" :
            [
            "case_image" : dataImage!,
                  "name" : caseName,
           "description" : caseDescription,
                   "url" : caseWebLink,
             "agency_id" : 1  //Change this in future
          ]
        ]
      }
      
      self.hideErrorInFieldsLabel()
      self.delegate?.createCaseRequest(params)
      
    } else {
      
      self.showErrorInFieldsLabel()
      
    }
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  
  //MARK: - VideoPlayerVimeoYoutubeDelegate
  
  func selectImageForCaseFromLibrary() {
      
    delegate?.selectImageCaseFromLibrary()
    
  }
  
  
}

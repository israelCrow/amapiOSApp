//
//  VideoPlayerVimeoYoutubeView.swift
//  Amap
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import YouTubePlayer
import YTVimeoExtractor
import AVKit
import AVFoundation

protocol VideoPlayerVimeoYoutubeViewDelegate {
  
  func selectImageForCaseFromLibrary()
  func askForDeleteCaseImage()
  
}

class VideoPlayerVimeoYoutubeView:UIView {
  
  private var videoURLString: String?
  private var videoURLNSURL: NSURL! = nil
  private var imageForCaseImageView: UIImageView! = nil
  var changeCaseImageButton: UIButton! = nil
  var deleteCaseImageButton: UIButton! = nil
  private var itsPossibleToChangeImage: Bool = false
  private var isYoutubeVideo: Bool = false
  private var isVimeoVideo: Bool = false
  private var loadingLabel: UILabel! = nil
  private var thumbNailOfVimeo: UIImageView?
  private var videoPlayerYoutube: YouTubePlayerView! = nil
  private var videoPlayerVimeoAVPlayer: AVPlayer! = nil
  private var isPlayingVidePlayerVimeoPlayer: Bool = false
  private var videoPlayerLayerVimeoAVPlayerLayer: AVPlayerLayer! = nil
  
  private var imageURL: String! = nil
  
  var existsImage: Bool = false
  
  var delegate: VideoPlayerVimeoYoutubeViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, url: String?, urlImage: String?) {
    
    if urlImage != nil {
      
      imageURL = urlImage!
    
    }
    
    if url != nil {
      
      videoURLString = url!
      videoURLNSURL = NSURL.init(string: url!)
      
    } else {
      
      videoURLString = nil
      videoURLNSURL = nil
      
    }
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  init(frame: CGRect, url: String?) {
    
    if url != nil {
      
      videoURLString = url!
      videoURLNSURL = NSURL.init(string: url!)
      
    } else {
      
      videoURLString = nil
      videoURLNSURL = nil
      
    }
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    if videoURLString == nil {
      
      self.createImageForCaseImageView()
      
    } else {
      
      self.checkForTypeOfVideo()
      
    }
    
  }
  
  private func createImageForCaseImageView() {
    
    let frameForImageView = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: self.frame.size.width,
                                     height: self.frame.size.height)
    
    imageForCaseImageView = UIImageView.init(frame: frameForImageView)
    imageForCaseImageView.backgroundColor = UIColor.lightGrayColor()
    imageForCaseImageView.userInteractionEnabled = true
    imageForCaseImageView.autoresizingMask = .FlexibleWidth
    imageForCaseImageView.contentMode = .ScaleAspectFit
    if imageURL != nil {
      imageForCaseImageView.imageFromUrl(imageURL)
    }
    self.addSubview(imageForCaseImageView)
    
    self.createChangeImageForCaseButton()
    self.createDeleteImageForCaseButton()
    
  }
  
  private func createChangeImageForCaseButton() {
    
    
    
//    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
//                                     y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
//                                     width: 28.0 * UtilityManager.sharedInstance.conversionWidth ,
//                                     height: 28.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForButton = CGRect.init(x: imageForCaseImageView.frame.size.width - (44.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: imageForCaseImageView.frame.size.height - (25.0 * UtilityManager.sharedInstance.conversionWidth),
                                 width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    changeCaseImageButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconAdd") as UIImage?
    changeCaseImageButton.setImage(image, forState: .Normal)
    
    changeCaseImageButton.addTarget(self,
                                  action: #selector(selectImageFromLibrary),
                        forControlEvents: .TouchUpInside)

    imageForCaseImageView.addSubview(changeCaseImageButton)
    
  }
  
  private func createDeleteImageForCaseButton() {
    
    let frameForButton = CGRect.init(x: imageForCaseImageView.frame.size.width - (20.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: imageForCaseImageView.frame.size.height - (25.0 * UtilityManager.sharedInstance.conversionWidth),
                                     width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    deleteCaseImageButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconClose") as UIImage?
    deleteCaseImageButton.setImage(image, forState: .Normal)
    
    deleteCaseImageButton.addTarget(self,
                                    action: #selector(askDeletingCaseImage),
                                    forControlEvents: .TouchUpInside)
    
    
    deleteCaseImageButton.frame = frameForButton
    
    imageForCaseImageView.addSubview(deleteCaseImageButton)
    
  }
  
  
  private func createLoadingLabel(message: String) {
    
    loadingLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Semibold",
                      size: 20.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: message,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.0),
        NSForegroundColorAttributeName: color
      ]
    )
    loadingLabel.attributedText = stringWithFormat
    loadingLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (loadingLabel.frame.size.width / 2.0),
                               y: loadingLabel.frame.origin.y + loadingLabel.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: loadingLabel.frame.size.width,
                               height: loadingLabel.frame.size.height)
    
    loadingLabel.frame = newFrame
    
    self.addSubview(loadingLabel)
    
  }
  
  private func checkForTypeOfVideo() {
    
    isYoutubeVideo = UtilityManager.sharedInstance.validateIfLinkIsYoutube(videoURLString)
    isVimeoVideo = UtilityManager.sharedInstance.validateIfLinkIsVimeo(videoURLString)
    
    if isYoutubeVideo == true {
      
      self.loadVideoPlayerYoutube()
      
    }else
      if isVimeoVideo == true {
        
        self.loadVideoPlayerVimeoAVPlayer()
        
      }else{
        
        self.createLoadingLabel("Can't load")
        self.createImageForCaseImageView()
        
    }
    
  }
  
  private func loadVideoPlayerYoutube() {
    
    let frameForPlayer = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: self.frame.size.width,
                                     height: self.frame.size.height)
    
    videoPlayerYoutube = YouTubePlayerView.init(frame: frameForPlayer)
    videoPlayerYoutube.loadVideoURL(NSURL.init(string: videoURLString!)!)
    self.addSubview(videoPlayerYoutube)
    
  }
  
  private func loadVideoPlayerVimeoAVPlayer() {
    
    let frameForVideoPlayer = CGRect.init(x: 0.0,
                                          y: 0.0,
                                          width: self.frame.size.width,
                                          height: self.frame.size.height)
    
    YTVimeoExtractor.sharedExtractor().fetchVideoWithVimeoURL(videoURLString!,
                                                              withReferer: nil)
    {
      (video, error) in
      if video != nil {
        
        let streamURLs = video?.streamURLs
        let videoLink_360 = streamURLs?[360] as? String
        let videoLink_720 = streamURLs?[720] as? String
        
//Uncomment this if you want to load thumbnail of the video
        
//        let thumbnailsURLs = video?.thumbnailURLs
//        let imageLink_320 = thumbnailsURLs?[320] as? String
//        let imageLink_640 = thumbnailsURLs?[640] as? String
//
//        
//        if imageLink_640 != nil {
//          
//          self.thumbNailOfVimeo = UIImageView.init(frame: frameForVideoPlayer)
//          self.thumbNailOfVimeo!.imageFromUrl(imageLink_640!)
//          self.addSubview(self.thumbNailOfVimeo!)
//          
//          let playVideoTap = UITapGestureRecognizer.init(target: self,
//                                                         action: #selector(self.playOrPauseVideoPlayerVimeo))
//          playVideoTap.numberOfTapsRequired = 1
//          self.thumbNailOfVimeo?.userInteractionEnabled = true
//          self.thumbNailOfVimeo?.addGestureRecognizer(playVideoTap)
//
//        } else
//          if imageLink_320 != nil {
//            
//            self.thumbNailOfVimeo = UIImageView.init(frame: frameForVideoPlayer)
//            self.thumbNailOfVimeo!.imageFromUrl(imageLink_320!)
//            self.addSubview(self.thumbNailOfVimeo!)
//            
//            let playVideoTap = UITapGestureRecognizer.init(target: self,
//                                                           action: #selector(self.playOrPauseVideoPlayerVimeo))
//            playVideoTap.numberOfTapsRequired = 1
//            self.thumbNailOfVimeo?.userInteractionEnabled = true
//            self.thumbNailOfVimeo?.addGestureRecognizer(playVideoTap)
//            
//        }
        
        if videoLink_720 != nil {
          
          self.videoPlayerVimeoAVPlayer = AVPlayer.init(URL: NSURL.init(string: videoLink_720!)!)
          self.videoPlayerLayerVimeoAVPlayerLayer = AVPlayerLayer.init(player: self.videoPlayerVimeoAVPlayer)
          self.videoPlayerLayerVimeoAVPlayerLayer.frame = frameForVideoPlayer
          self.layer.addSublayer(self.videoPlayerLayerVimeoAVPlayerLayer)
          //                self.videoPlayerVimeoAVPlayer.play()
          
          let playVideoTap = UITapGestureRecognizer.init(target: self,
                                                         action: #selector(self.playOrPauseVideoPlayerVimeo))
          playVideoTap.numberOfTapsRequired = 1
          self.userInteractionEnabled = true
          self.addGestureRecognizer(playVideoTap)

          
        }else
          if videoLink_360 != nil {
            
            self.videoPlayerVimeoAVPlayer = AVPlayer.init(URL: NSURL.init(string: videoLink_360!)!)
            self.videoPlayerLayerVimeoAVPlayerLayer = AVPlayerLayer.init(player: self.videoPlayerVimeoAVPlayer)
            self.videoPlayerLayerVimeoAVPlayerLayer.frame = frameForVideoPlayer
            self.layer.addSublayer(self.videoPlayerLayerVimeoAVPlayerLayer)
            //                  self.videoPlayerVimeoAVPlayer.play()
            
            let playVideoTap = UITapGestureRecognizer.init(target: self,
                                                           action: #selector(self.playOrPauseVideoPlayerVimeo))
            playVideoTap.numberOfTapsRequired = 1
            self.userInteractionEnabled = true
            self.addGestureRecognizer(playVideoTap)

            
        }
      }
    }
  }
  
  func changeImageOfCase(newImage: UIImage) {

    imageForCaseImageView.backgroundColor = UIColor.whiteColor()
    imageForCaseImageView.image = newImage
    
    existsImage = true
   
  }
  
  @objc private func askDeletingCaseImage() {
    
    self.delegate?.askForDeleteCaseImage()
    
  }
  
  func deleteImageOfCase() {
    
    imageForCaseImageView.backgroundColor = UIColor.lightGrayColor()
    imageForCaseImageView.image = nil
    
    existsImage = false
    
  }
  
  @objc private func selectImageFromLibrary() {
   
    self.delegate?.selectImageForCaseFromLibrary()
    
  }
  
  @objc private func playOrPauseVideoPlayerVimeo() {
    
    if isPlayingVidePlayerVimeoPlayer != true {
      
      videoPlayerVimeoAVPlayer.play()
      isPlayingVidePlayerVimeoPlayer = true
      
    }else{
      
      videoPlayerVimeoAVPlayer.pause()
      isPlayingVidePlayerVimeoPlayer = false
      
    }
    
  }
  
}
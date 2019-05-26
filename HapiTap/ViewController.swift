//
//  ViewController.swift
//  HapiTap
//
//  Created by Pramahadi Tama Putra on 17/05/19.
//  Copyright © 2019 Pramahadi Tama Putra. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import Lottie
import SCLAlertView

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    var counterTouch = 0
    var counterNot = 0
    var finalAnswer: String = ""
    
    var notTwinkleLittleStar: [Int] = [
        0,0,4,4,5,5,4,
        3,3,2,2,1,1,0,
        4,4,3,3,2,2,1,
        4,4,3,3,2,2,1,
        0,0,4,4,5,5,4,
        3,3,2,2,1,1,0
    ]
    
    var toneNotasiAngka: [String] = [
        "do",
        "re",
        "mi",
        "fa",
        "sol",
        "la",
        "si"
    ]
    
    var toneBackGroundColor: [CGColor] = [
        #colorLiteral(red: 0.003921568627, green: 0.7450980392, blue: 0.9960784314, alpha: 1),
        #colorLiteral(red: 1, green: 0.8666666667, blue: 0, alpha: 1),
        #colorLiteral(red: 1, green: 0.4901960784, blue: 0, alpha: 1),
        #colorLiteral(red: 0.5607843137, green: 0, blue: 1, alpha: 1),
        #colorLiteral(red: 0.6784313725, green: 1, blue: 0.007843137255, alpha: 1),
    ]
    
    var toneViewBackgroundColor: [CGColor] = [
        #colorLiteral(red: 0.3294117647, green: 1, blue: 0.9843137255, alpha: 1),
        #colorLiteral(red: 1, green: 0.9176470588, blue: 0.4235294118, alpha: 1),
        #colorLiteral(red: 1, green: 0.6039215686, blue: 0.3333333333, alpha: 1),
        #colorLiteral(red: 0.9058823529, green: 0.6980392157, blue: 1, alpha: 1),
        #colorLiteral(red: 0.537254902, green: 1, blue: 0.8, alpha: 1),
    ]
    
    var tapToneSounds: [String] = [
        "bubbles",
        "clay",
        "confetti",
        "corona",
        "dotted-spiral",
        "flash-1",
        "flash-2",
        "flash-3",
        "glimmer",
        "moon",
        "pinwheel",
        "piston-1",
        "piston-2",
        "piston-3",
        "prism-1",
        "prism-2",
        "prism-3",
        "splits",
        "squiggle",
        "strike",
        "suspension",
        "timer",
        "ufo",
        "veil",
        "wipe",
        "zig-zag"
    ]
    
    
    
    
    @IBOutlet weak var mainToneContainers: UIView!
    @IBOutlet var toneContainers: [UIView]!
    @IBOutlet weak var startContainer: AnimationView!
    @IBOutlet weak var resultContainer: AnimationView!
    @IBOutlet var fireworkContainers: [AnimationView]!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        startContainer.transform = CGAffineTransform(scaleX: 5, y: 5)
        resultContainer.transform = CGAffineTransform(scaleX: 5, y: 5)
        for fireworkContainer in fireworkContainers {
            fireworkContainer.transform = CGAffineTransform(scaleX: 5, y: 5)
        }
        setBeginingShapeState()
        startGameAnimation()
        
    }
    
    func startGameAnimation() {
        
        self.view.isUserInteractionEnabled = false
        
        UIView.animateKeyframes(withDuration: 10.0, delay: 0, options: [.calculationModeCubic], animations: {
            // Add animations
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2.0/10.0,animations: {
                let startAnimation = Animation.named("tapHere")
                self.startContainer.animation = startAnimation
                self.startContainer.loopMode = .loop
                self.startContainer.play()
                self.startContainer.frame = CGRect(x: 20, y: 44, width: 250, height: 250)
            })
            UIView.addKeyframe(withRelativeStartTime: 2.0/10.0, relativeDuration: 2.0/10.0, animations: {
                self.startContainer.frame = CGRect(x: 144, y: 612, width: 250, height: 250)
                
            })
            UIView.addKeyframe(withRelativeStartTime: 4.0/10.0, relativeDuration: 2.0/10.0, animations: {
                self.startContainer.frame = CGRect(x: 144, y: 44, width: 250, height: 250)
            })
            UIView.addKeyframe(withRelativeStartTime: 6.0/10.0, relativeDuration: 2.0/10.0, animations: {
                self.startContainer.frame = CGRect(x: 20, y: 612, width: 250, height: 250)
            })
            UIView.addKeyframe(withRelativeStartTime: 8.0/10.0, relativeDuration: 2.0/10.0, animations: {
                self.startContainer.frame = CGRect(x: 82, y: 323, width: 250, height: 250)
            })
        }, completion:{ _ in
            self.view.isUserInteractionEnabled = true
            print("I'm done!")
        })
        
    }
    
    func setBeginingShapeState() {
        // Do any additional setup after loading the view.
        mainToneContainers.layer.opacity = 0
        mainToneContainers.layer.cornerRadius = mainToneContainers.frame.width/2
        for toneContainer in toneContainers {
            toneContainer.layer.opacity = 0
            toneContainer.layer.cornerRadius = toneContainer.frame.width/2
        }
    }
    
    func toneContainersAnimation(_ randomCircle: Int, _ randomScale2: Int, _ randomColor2: Int, _ randomRadius2: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.toneContainers[randomCircle].transform = CGAffineTransform(scaleX: CGFloat(randomScale2), y: CGFloat(randomScale2))
            self.toneContainers[randomCircle].layer.opacity = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.toneContainers[randomCircle].layer.backgroundColor = self.toneBackGroundColor[randomColor2]
                let positionView = self.toneContainers[randomCircle].center
                let pulse = PulseAnimation(numberOfPulses: 1, radius: CGFloat(randomRadius2), position: positionView)
                pulse.backgroundColor = self.toneBackGroundColor[randomColor2]
                pulse.animationDuration = 1
                self.view.layer.insertSublayer(pulse, below: self.toneContainers[randomCircle].layer)
                self.toneContainers[randomCircle].transform = .identity
                self.toneContainers[randomCircle].layer.opacity = 0
            })
        }
    }
    
    func mainToneContainersAnimation(_ position: CGPoint, _ randomScale1: Int, _ randomColor1: Int, _ randomRadius1: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            
            
            
            if self.counterTouch >= 0 && self.counterTouch <= 6 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[0]
            }else if self.counterTouch > 6 && self.counterTouch <= 13 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[1]
            }else if self.counterTouch > 13 && self.counterTouch <= 20 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[2]
            }else if self.counterTouch > 20 && self.counterTouch <= 27 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[3]
            }else if self.counterTouch > 27 && self.counterTouch <= 34 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[4]
            }else if self.counterTouch > 34 && self.counterTouch <= 41 {
                self.view.layer.backgroundColor = self.toneViewBackgroundColor[1]
            }
            
            self.startContainer.isHidden = true
            self.resultContainer.isHidden = true
            
            self.mainToneContainers.center = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
            self.mainToneContainers.transform = CGAffineTransform(scaleX: CGFloat(randomScale1), y: CGFloat(randomScale1))
            self.mainToneContainers.layer.opacity = 1
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                self.mainToneContainers.layer.backgroundColor = self.toneBackGroundColor[randomColor1]
                let positionView = self.mainToneContainers.center
                let pulse = PulseAnimation(numberOfPulses: 1, radius: CGFloat(randomRadius1), position: positionView)
                pulse.backgroundColor = self.toneBackGroundColor[randomColor1]
                pulse.animationDuration = 1
                self.view.layer.insertSublayer(pulse, below: self.mainToneContainers.layer)
                self.mainToneContainers.transform = .identity
                self.mainToneContainers.layer.opacity = 0
            })
        }
    }
    
    func checkAnswerSound(named:String){
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        guard let url = Bundle.main.url(forResource: named, withExtension: "wav", subdirectory: "ToneSound") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound() {
        
        if counterNot <= 41 {
        
            guard let url = Bundle.main.url(forResource: toneNotasiAngka[notTwinkleLittleStar[counterNot]], withExtension: "wav", subdirectory: "ToneSound") else { return }
        
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                /* iOS 10 and earlier require the following line:
                 player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                
                guard let player = player else { return }
                
                player.play()
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            counterNot+=1
            counterTouch += 1
        }else if counterNot > 41{
            counterNot = 0
            counterTouch = 0
            
            // Add a text field
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false,
                showCircularIcon: true
                
            )
            let alert = SCLAlertView(appearance: appearance)
            let icon = UIImage(named: "question")
            
            let txt = alert.addTextField("Enter Song Name")
            alert.addButton("Answer") {
                self.finalAnswer = txt.text!.lowercased()
                if  self.finalAnswer == "little star" ||
                    self.finalAnswer == "littlestar" ||
                    self.finalAnswer == "twinkle little star" ||
                    self.finalAnswer == "twinklelittlestar" ||
                    self.finalAnswer == "twinkle" ||
                    self.finalAnswer == "twinkle twinkle" ||
                    self.finalAnswer == "twinkletwinkle" ||
                    self.finalAnswer == "twinkle-twinkle" ||
                    self.finalAnswer == "twinkle twinkle little star" ||
                    self.finalAnswer == "twinkletwinkle little star" ||
                    self.finalAnswer == "twinkletwinkle littlestar" ||
                    self.finalAnswer == "twinkle twinkle littlestar" ||
                    self.finalAnswer == "twinkletwinklelittlestar" ||
                    self.finalAnswer == "twinkle-twinkle little star" ||
                    self.finalAnswer == "twinkle-twinkle littlestar" ||
                    self.finalAnswer == "twinkle-twinklelittlestar" {
                    
//                        self.view.isUserInteractionEnabled = false
                        self.view.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.9803921569, blue: 0.4745098039, alpha: 1)
                        self.checkAnswerSound(named: "correct")
                        let happyAnimation = Animation.named("happyTogether")
                        self.resultContainer.isHidden = false
                        self.resultContainer.animation = happyAnimation
                        self.resultContainer.loopMode = .loop
                        self.resultContainer.play()
                    
                    
                }else {
                    self.view.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
                    self.checkAnswerSound(named: "incorrect")
                    let cryAnimation = Animation.named("cry")
                    self.resultContainer.isHidden = false
                    self.resultContainer.animation = cryAnimation
                    self.resultContainer.loopMode = .loop
                    self.resultContainer.play()
                }
            }
            alert.showEdit("QUIZ", subTitle: "What's Song Name ?", circleIconImage: icon)
    
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        print(self.counterTouch)
        print(self.counterNot)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        playSound()
        let randomScale1 = Int.random(in: 1...4)
        let randomRadius1 = Int.random(in: 150...200)
        let randomScale2 = Int.random(in: 1...2)
        let randomRadius2 = Int.random(in: 100...150)
        let randomColor1 = Int.random(in: 0...4)
        let randomColor2 = Int.random(in: 0...4)
        let randomCircle = Int.random(in: 0...31)
        if let touch = touches.first {
            let position = touch.location(in: view)
            mainToneContainersAnimation(position, randomScale1, randomColor1, randomRadius1)
            toneContainersAnimation(randomCircle, randomScale2, randomColor2, randomRadius2)
        }
    }
}


//
//  SettingsViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 13/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import GoogleMobileAds

var musicIsStopped = true

class SettingsViewController: UIViewController, GADBannerViewDelegate {
    
    var products = [SKProduct]()
    
    @IBOutlet var winningScoreButton: UIButton!
    @IBOutlet var bannerViewAdvert: GADBannerView!
    @IBOutlet var custonWinValueTextField: UITextField!
    @IBOutlet var team1BackgroundColour: UIButton!
    @IBOutlet var team2BackgroundColour: UIButton!
    @IBOutlet var soundState: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.bool(forKey: "com.IdleApps.Tapped.RemovingAds") == true {
            print("User has purchased Remove Ads. Removing..")
            bannerViewAdvert.isHidden = true
        } else {
            print("User has not purchased Remove Ads. Displaying..")
            let request = GADRequest()
            request.testDevices = [kGADSimulatorID, "ca-app-pub-8403640993517419/6755607485"]
            bannerViewAdvert.delegate = self
            bannerViewAdvert.adUnitID = "ca-app-pub-8403640993517419/6755607485"
            bannerViewAdvert.rootViewController = self
            bannerViewAdvert.load(request)
            bannerViewAdvert.isHidden = false
        }
        
        if let winningValue = UserDefaults.standard.value(forKey: "winValue") as? String {
            if winningValue == "9" {
                winningScoreButton.setTitle("Winner at: 10", for: .normal)
            } else if winningValue == "24" {
                winningScoreButton.setTitle("Winner at: 25", for: .normal)
            } else if winningValue == "49" {
                winningScoreButton.setTitle("Winner at: 50", for: .normal)
            } else if winningValue == "99" {
                winningScoreButton.setTitle("Winner at: 100", for: .normal)
            } else {
                
                let value: String = UserDefaults.standard.value(forKey: "winValue") as! String
                let x: Int? = Int(value)
                
                if (x != nil) {
                    // Successfully converted String to Int
                    let finalValue = x! + 1
                    
                    let y: Int = finalValue
                    let chosenValue = String(y)
                    
                    custonWinValueTextField.placeholder = chosenValue
                    winningScoreButton.setTitle("Winner at: Custom", for: .normal)
                }
            }
        }
        
        if UserDefaults.standard.bool(forKey: "com.IdleApps.Tapped.CustomWinValue") == false {
            if winningScoreButton.currentTitle != "Winner at: Custom" {
                custonWinValueTextField.isHidden = true
            }
        } else {
            if winningScoreButton.currentTitle != "Winner at: Custom" {
                custonWinValueTextField.isHidden = true
            }
        }
        
        if let team1Colour = UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String {
            
            if team1Colour == "Red" {
                team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0)
            } else if team1Colour == "Blue" {
                team1BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0)
            } else if team1Colour == "Green" {
                team1BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0)
            } else if team1Colour == "Yellow" {
                team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0)
            } else if team1Colour == "Purple" {
                team1BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0)
            } else {
                team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0)
                UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
            }
            
        }
        
        if let team2Colour = UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String {
            
            if team2Colour == "Red" {
                team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0)
            } else if team2Colour == "Blue" {
                team2BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0)
            } else if team2Colour == "Green" {
                team2BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0)
            } else if team2Colour == "Yellow" {
                team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0)
            } else if team2Colour == "Purple" {
                team2BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0)
            } else {
                team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0)
                UserDefaults.standard.set("Red", forKey: "team2BackgroundColour")
            }
            
        }
        
        
    }

    @IBAction func winningScoreChangedAction(_ sender: Any) {
        
        if winningScoreButton.currentTitle == "Winner at: 10" {
            winningScoreButton.setTitle("Winner at: 25", for: .normal)
            UserDefaults.standard.set("24", forKey: "winValue")
            custonWinValueTextField.isHidden = true
        } else if winningScoreButton.currentTitle == "Winner at: 25" {
            UserDefaults.standard.set("49", forKey: "winValue")
            winningScoreButton.setTitle("Winner at: 50", for: .normal)
            custonWinValueTextField.isHidden = true
        } else if winningScoreButton.currentTitle == "Winner at: 50" {
            UserDefaults.standard.set("99", forKey: "winValue")
            winningScoreButton.setTitle("Winner at: 100", for: .normal)
            custonWinValueTextField.isHidden = true
        } else if winningScoreButton.currentTitle == "Winner at: 100" {
            
            if UserDefaults.standard.bool(forKey: "com.IdleApps.Tapped.CustomWinValue") == true {
                // The user has the permissions to set a custom win value
                print("Custom win value box selected")
                custonWinValueTextField.isHidden = false
                winningScoreButton.setTitle("Winner at: Custom", for: .normal)
                
            } else {
                // The user doesn't have the permissions to set a custom win value
                UserDefaults.standard.set("9", forKey: "winValue")
                winningScoreButton.setTitle("Winner at: 10", for: .normal)
                custonWinValueTextField.isHidden = true
            }
            
            
            
        } else if winningScoreButton.currentTitle == "Winner at: Custom" {
            UserDefaults.standard.set("9", forKey: "winValue")
            winningScoreButton.setTitle("Winner at: 10", for: .normal)
            custonWinValueTextField.isHidden = true
        } else {
            UserDefaults.standard.set("9", forKey: "winValue")
            winningScoreButton.setTitle("Winner at: 10", for: .normal)
            custonWinValueTextField.isHidden = true
        }
    
        print(UserDefaults.standard.value(forKey: "winValue")!)
        
    }
    
    @IBAction func customWinValueEntered(_ sender: Any) {
        
        let value: String = custonWinValueTextField.text!
        let x: Int? = Int(value)
        
        if (x != nil) {
            // Successfully converted String to Int
            let finalValue = x! - 1
            
            let y: Int = finalValue
            let chosenValue = String(y)
            print(chosenValue)
            UserDefaults.standard.set(chosenValue, forKey: "winValue")
        }
        
        
        print(UserDefaults.standard.value(forKey: "winValue")!)
    }
    
    
    @IBAction func team1ColourChanged(_ sender: Any) {
        
        print(UserDefaults.standard.value(forKey: "team1BackgroundColour") as! String)
        
        if let currentTeam1Colour = UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String {
            
            if currentTeam1Colour == "Red" {
                
                if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == "Blue" {
                    UserDefaults.standard.set("Green", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Green
                } else {
                    
                    UserDefaults.standard.set("Blue", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Blue
                    
                }
                
            } else if currentTeam1Colour == "Blue" {
                
                if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == "Green" {
                    UserDefaults.standard.set("Yellow", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Yellow
                } else {
                    
                    UserDefaults.standard.set("Green", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Green
                    print("Debug 1")
                    
                }
                
            } else if currentTeam1Colour == "Green" {
                
                if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == "Yellow" {
                    UserDefaults.standard.set("Purple", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Purple
                } else {
                    
                    UserDefaults.standard.set("Yellow", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Yellow
                    
                }
                
            } else if currentTeam1Colour == "Yellow" {
                
                if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == "Purple" {
                    UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Red
                } else {
                    
                    UserDefaults.standard.set("Purple", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Purple
                    
                }
                
            } else if currentTeam1Colour == "Purple" {
                
                if UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String == "Red" {
                    UserDefaults.standard.set("Blue", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Blue
                } else {
                    
                    UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
                    team1BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Red
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    @IBAction func team2ColourChanged(_ sender: Any) {
        
        print(UserDefaults.standard.value(forKey: "team2BackgroundColour") as! String)
        
        if let currentTeam2Colour = UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String {
            
            if currentTeam2Colour == "Red" {
                
                if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == "Blue" {
                    UserDefaults.standard.set("Green", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Green
                    print("Debug 2")
                } else {
                    
                    UserDefaults.standard.set("Blue", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Blue
                    print("Debug 3")
                    
                }
                
            } else if currentTeam2Colour == "Blue" {
                
                if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == "Green" {
                    UserDefaults.standard.set("Yellow", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Yellow
                    print("Debug 4")
                } else {
                    
                    UserDefaults.standard.set("Green", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Green
                    print("Debug 5")
                    
                }
                
            } else if currentTeam2Colour == "Green" {
                
                if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == "Yellow" {
                    UserDefaults.standard.set("Purple", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Purple
                } else {
                    
                    UserDefaults.standard.set("Yellow", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Yellow
                    
                    
                }
                
            } else if currentTeam2Colour == "Yellow" {
                
                if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == "Purple" {
                    UserDefaults.standard.set("Red", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Red
                } else {
                    
                    UserDefaults.standard.set("Purple", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Purple
                    
                }
                
            } else if currentTeam2Colour == "Purple" {
                
                if UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String == "Red" {
                    UserDefaults.standard.set("Blue", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Blue
                } else {
                    
                    UserDefaults.standard.set("Red", forKey: "team2BackgroundColour")
                    team2BackgroundColour.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Red
                    
                }
                
                
                
            }
            
        }
   
    }
    
    
    @IBAction func soundStateChanged(_ sender: Any) {
        
        if musicIsStopped == true {
            soundState.setImage(UIImage(named: "Sound_State:Muted"), for: .normal)
            print("State Changed (Stopped)")
            shouldStop = true
            musicIsStopped = false
        } else {
            soundState.setImage(UIImage(named: "Sound_State:Playing"), for: .normal)
            print("State Changed (Playing)")
            GSAudio.sharedInstance.playSound(soundFileName: "Soundtrack")
            shouldStop = false
            musicIsStopped = true
        }
        
    }
    
    
    //RED       team1BackgroundColour.backgroundColor = UIColor(red: 255, green: 125, blue: 107, alpha: 1)
    //BLUE      team1BackgroundColour.backgroundColor = UIColor(red: 99, green: 125, blue: 255, alpha: 1)
    //GREEN     team1BackgroundColour.backgroundColor = UIColor(red: 74, green: 208, blue: 56, alpha: 1)
    //YELLOW    team1BackgroundColour.backgroundColor = UIColor(red: 255, green: 255, blue: 102, alpha: 1)
    //PURPLE    team1BackgroundColour.backgroundColor = UIColor(red: 178, green: 102, blue: 255, alpha: 1)
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        custonWinValueTextField.resignFirstResponder()
    }
    
}

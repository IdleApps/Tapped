//
//  TappedViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 13/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import AVFoundation

class TappedViewController: UIViewController {
    
    
    @IBOutlet var redTeamScore: UIButton!
    @IBOutlet var blueTeamScore: UIButton!
    @IBOutlet var redTeamScoreLabel: UILabel!
    @IBOutlet var blueTeamScoreLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        redTeamScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) // Rotates 180°
        redTeamScore.transform = CGAffineTransform(rotationAngle: CGFloat.pi) // Rotates 180°
        
        
        if let team1Colour = UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String {
            
            if team1Colour == "Red" { // Team 1's chosen background colour is RED.
                redTeamScore.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes the view's background colour
            } else if team1Colour == "Blue" { // Team 1's chosen background colour is BLUE.
                redTeamScore.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes the view's background colour
            } else if team1Colour == "Green" { // Team 1's chosen background colour is GREEN.
                redTeamScore.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Changes the view's background colour
            } else if team1Colour == "Yellow" { // Team 1's chosen background colour is YELLOW.
                redTeamScore.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Changes the view's background colour
            } else if team1Colour == "Purple" { // Team 1's chosen background colour is PURPLE.
                redTeamScore.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Changes the view's background colour
            } else { // No colour found. Setting to default (RED)
                redTeamScore.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes background colour
                blueTeamScoreLabel.textColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes label colour
                view.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes the view's background colour

                UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
            }
        }
        
        if let team2Colour = UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String {
            
            if team2Colour == "Red" { // Team 2's chosen background colour is RED.
                blueTeamScore.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 1.0) // Changes label colour.
            } else if team2Colour == "Blue" { // Team 2's chosen background colour is BLUE.
                blueTeamScore.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes label colour.
            } else if team2Colour == "Green" { // Team 2's chosen background colour is GREEN.
                blueTeamScore.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 1.0) // Changes label colour.
            } else if team2Colour == "Yellow" { // Team 2's chosen background colour is YELLOW.
                blueTeamScore.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0) // Changes label colour.
            } else if team2Colour == "Purple" { // Team 2's chosen background colour is PURPLE.
                blueTeamScore.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 1.0) // Changes label colour.
            } else { // No colour found. Setting to default (BLUE)
                blueTeamScore.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes background colour.
                redTeamScoreLabel.textColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 1.0) // Changes label colour.
                UserDefaults.standard.set("Red", forKey: "team2BackgroundColour")
            }
        }
    }
    
    
    @IBAction func redTeamClickedAction(_ sender: Any) { // Activates every time the red team is clicked.
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "Pop", ofType: "mp3")
            
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        } catch {
            print("There was an error")
        }
        
        audioPlayer.play()
        
        let target = UserDefaults.standard.value(forKey: "winValue") as! String // The win value set in the settings menu.
        let targetInt = Int(target)! + 1 // Adds 1 to suffise UserDefaults.
        
        if redTeamScoreLabel.text! == target { // Activates when the winValue and score are equal.
            
            print("The red team has successfully hit the larget: \(targetInt)")
            
            self.perform(#selector(presentWinScreen), with: nil, afterDelay: 0) // Displays the winner screen.
            
            winner = "Red" // Sets the winner to be the red team.
            
        }
        
        var redScore = Int(redTeamScoreLabel.text!) // Converts the score into an integer.
        redScore = redScore! + 1 // Adds 1.
        redTeamScoreLabel.text! = String(redScore!) // Converts the score back into a string and applys changes onto the label.
        print("The red score is: \(redScore!)")
        
    }

    @IBAction func blueTeamClickedAction(_ sender: Any) { // Activates every time the blue team is clicked.
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "Pop", ofType: "mp3")
            
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
        } catch {
            print("There was an error")
        }
        
        audioPlayer.play()
        
        let target = UserDefaults.standard.value(forKey: "winValue") as! String
        let targetInt = Int(target)! + 1
        
        if blueTeamScoreLabel.text! == target { // Activates when the winValue and score are equal.
            
            print("The blue team has successfully hit the target: \(targetInt)")
            
            self.perform(#selector(presentWinScreen), with: nil, afterDelay: 0) // Displays the winner screen.
            
            winner = "Blue" // Sets the winner to be the blue team.
            
        }
        
        var blueScore = Int(blueTeamScoreLabel.text!) // Converts the score into an integer.
        blueScore = blueScore! + 1 // Adds 1.
        blueTeamScoreLabel.text! = String(blueScore!) // Converts the score back info a string and applys changes onto the label.
        print("The blue score is: \(blueScore!)")
        
    }
    
    
    func presentWinScreen() { // Shows the winners view controller.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WinScreen") as UIViewController
        present(vc, animated: true)
    }
    
}

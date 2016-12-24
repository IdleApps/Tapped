//
//  WinScreenViewController.swift
//  Tapped
//
//  Created by Luke Cheskin on 17/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

var winner = ""
var after2Seconds = true

class WinScreenViewController: UIViewController {

    @IBOutlet var redTeamLabel: UILabel!
    @IBOutlet var blueTeamLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        after2Seconds = false
        
        let seconds2 = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: seconds2) {
            // Stops the user from dismissing the winner's screen until 2 seconds have passed.
            after2Seconds = true
        }
    
        redTeamLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi) // Rotates 180°
        
        if let team1Colour = UserDefaults.standard.value(forKey: "team1BackgroundColour") as? String {
            
            if team1Colour == "Red" {
                redTeamLabel.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 0.8)
            } else if team1Colour == "Blue" {
                redTeamLabel.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 0.8)
            } else if team1Colour == "Green" {
                redTeamLabel.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 0.8)
            } else if team1Colour == "Yellow" {
                redTeamLabel.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 0.8)
            } else if team1Colour == "Purple" {
                redTeamLabel.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 0.8)
            } else {
                redTeamLabel.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 0.8)
                UserDefaults.standard.set("Red", forKey: "team1BackgroundColour")
            }
        }
        
        if let team2Colour = UserDefaults.standard.value(forKey: "team2BackgroundColour") as? String {
            
            if team2Colour == "Red" {
                blueTeamLabel.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 0.8)
            } else if team2Colour == "Blue" {
                blueTeamLabel.backgroundColor = UIColor(red: 99/255, green: 125/255, blue: 255/255, alpha: 0.8)
            } else if team2Colour == "Green" {
                blueTeamLabel.backgroundColor = UIColor(red: 74/255, green: 208/255, blue: 56/255, alpha: 0.8)
            } else if team2Colour == "Yellow" {
                blueTeamLabel.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 0.8)
            } else if team2Colour == "Purple" {
                blueTeamLabel.backgroundColor = UIColor(red: 178/255, green: 102/255, blue: 255/255, alpha: 0.8)
            } else {
                blueTeamLabel.backgroundColor = UIColor(red: 255/255, green: 125/255, blue: 107/255, alpha: 0.8)
                UserDefaults.standard.set("Red", forKey: "team2BackgroundColour")
            }
        }
        

        if winner == "Red" {
            print("The red team has won. Displaying..")
            
            setWinner(winningTeam: "Red")
            
        } else if winner == "Blue" {
            print("The blue team has won. Displaying..")
            
            setWinner(winningTeam: "Blue")
            
        } else {
         print("An error occured")
        }
    }
    
    
    @IBAction func dismissWinScreen(_ sender: Any) {
        
        if after2Seconds == true {
            self.perform(#selector(presentHomeScreen), with: nil, afterDelay: 0)
        }
    }
    
    func setWinner(winningTeam: String) {
        if winningTeam == "Red" {
            redTeamLabel.text! = "You win!"
            blueTeamLabel.text! = "You lose!"
        } else if winningTeam == "Blue" {
            redTeamLabel.text! = "You lose!"
            blueTeamLabel.text! = "You win!"
        }
    }
    
    func presentHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as UIViewController
        present(vc, animated: true)
    }
    
    
}

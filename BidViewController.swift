//
//  BidViewController.swift
//  BidTacToe2
//
//  Created by Tanja Keune on 9/1/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit


class BidViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    
    @IBOutlet weak var player1CreditsLabel: UILabel!
    @IBOutlet weak var player2CreditsLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var textFieldBid: UITextField!
    
    @IBOutlet weak var labelWhosTurn: UILabel!
    
    var playerOnMove = 0
    
    var player1: Int = Int()
    var player2: Int = Int()
    
    var bidX = -1
    var bidO = -1
    
    var scoreUpdate = -1
    
    var presentAd = false
    
    var activeBidder: Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlayers()
        setupNavigationBar()
        setupScore()
        print("player1 - view did load = \(player1)")
        print("player2 - view did load = \(player2)")
        self.view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 240/255, alpha: 1)

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        textFieldBid.delegate = self
        getPlayers()
        activeBidder = player1
        print("ActiveBidder = \(activeBidder) Player1 = \(player1)")
        print("activeBidder - from viewWillAppear = \(activeBidder)")
        setupImagesAndCredits()
        
        if scoreUpdate >= 0 {
            
//            if scoreUpdate == 1 {
////                add score to X
//                let score = (UserDefaults.standard.object(forKey: "playerXScore") as! Int) + 1
//                UserDefaults.standard.set(score, forKey: "playerXScore")
//            } else if scoreUpdate == 2 {
////                add score to o
//                
//                let score = (UserDefaults.standard.object(forKey: "playerOScore") as! Int) + 1
//                UserDefaults.standard.set(score, forKey: "playerOScore")
//            }
//            game was over reset credits
            
            resetCredits()
            setupScore()

        }

        
    }
    
    func getPlayers() {
        
        player1 = UserDefaults.standard.object(forKey: "player1") as! Int
        player2 = UserDefaults.standard.object(forKey: "player2") as! Int
        
    }
    func resetCredits() {
        
        switch player1 {
        case 1:
            labelWhosTurn.text = " X make your bid: "
            UserDefaults.standard.set(100, forKey: "playerXCredits")
            UserDefaults.standard.set(100, forKey: "playerOCredits")
    
        case 2:
            labelWhosTurn.text = " O make your bid: "
            UserDefaults.standard.set(100, forKey: "playerXCredits")
            UserDefaults.standard.set(100, forKey: "playerOCredits")
            
        default:
            break
        }

    }
    
    func resetScore() {
        
        switch player1 {
        case 1:
           
            UserDefaults.standard.set(0, forKey: "playerXScore")
            UserDefaults.standard.set(0, forKey: "playerOScore")
        case 2:
            UserDefaults.standard.set(0, forKey: "playerXScore")
            UserDefaults.standard.set(0, forKey: "playerOScore")
            
        default:
            break
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupImagesAndCredits() {
        
        if player1 == 1 {
            
            labelWhosTurn.text = " X make your bid: "
            player1Image.image = UIImage(named: "crosses.png")
            player2Image.image = UIImage(named: "Noughts.png")
            
            player1CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerXCredits")!)
            player2CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerOCredits")!)

        } else {
            
            labelWhosTurn.text = " O make your bid: "
            player2Image.image = UIImage(named: "crosses.png")
            player1Image.image = UIImage(named: "Noughts.png")
            
            player1CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerOCredits")!)
            player2CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerXCredits")!)
        }

    }
    
    func setupScore() {
        
        let playerXScore = UserDefaults.standard.object(forKey: "playerXScore")!
        let playerOScore = UserDefaults.standard.object(forKey: "playerOScore")!
        
        if player1 == 1 {
            
            scoreLabel.text = "\(playerXScore) : \(playerOScore)"
            
        } else {
            
            scoreLabel.text = "\(playerOScore) : \(playerXScore)"

        }
    }
    
    func setupNavigationBar() {
        
        self.navigationItem.hidesBackButton = true
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        logo.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        logo.contentMode = .scaleAspectFit
        
        navigationItem.titleView = logo
        
    }
  
    @IBAction func bidButton(_ sender: Any) {
        
        
        let playerXCredits = UserDefaults.standard.object(forKey: "playerXCredits") as! Int
        let playerOCredits = UserDefaults.standard.object(forKey: "playerOCredits") as! Int

        
        if textFieldBid.text != "" {
            
//              convert into Int
            
            let bid = Int(textFieldBid.text!)!
            
            switch activeBidder {
            case 1:
//                check for credits
//                adBidsCounter
                if bid <= playerXCredits {
                    
                    bidX = bid
                    activeBidder = 2
                    textFieldBid.text = ""
                    labelWhosTurn.text = " 0 make your bid: "
                    
                } else {
                    //                    not enough credits
                    self.alertMessage(title: "Not enough credits", message: "Try again")
                }
            case 2:
                
                if bid <= playerOCredits {
                    
                    bidO = bid
                    activeBidder = 1
                    textFieldBid.text = ""
                    labelWhosTurn.text = " X make your bid: "

                    
                } else {
                    //                    not enough credits
                    self.alertMessage(title: "Not enough credits", message: "Try again")
                    
                }
                    
                    default:
                    break
                
                
                
            }
            print("BID BUTTON: bid = \(bid) bidX = \(bidX) bidO = \(bidO)")

        }
        
//        check if you have two bids to compare
        
        if bidX >= 0 && bidO >= 0 {
            
            if bidX > bidO {
                
//                x won
                playerOnMove = 1
                UserDefaults.standard.set(playerXCredits - bidX, forKey: "playerXCredits")
                UserDefaults.standard.set(playerOCredits + bidX, forKey: "playerOCredits")
                performSegue(withIdentifier: "makeMove", sender: nil)
                
            } else if bidX < bidO {
                
//                o won
                playerOnMove = 2
                UserDefaults.standard.set(playerXCredits + bidO, forKey: "playerXCredits")
                UserDefaults.standard.set(playerOCredits - bidO, forKey: "playerOCredits")
                performSegue(withIdentifier: "makeMove", sender: nil)
            } else {
                
//                tie
                bidO = -1
                bidX = -1
                alertMessage(title: "The bid was tie", message: "Go again")
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "makeMove" {
            
            let destination = segue.destination as! TicTacViewController
            
            destination.playerOnMove = playerOnMove
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

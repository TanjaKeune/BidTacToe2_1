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
    @IBOutlet weak var toolBar: UIToolbar!
    
    var playerOnMove = 0
    
    var player1: Int = Int()
    var player2: Int = Int()
    
    var bidX = -1
    var bidO = -1
    
    var scoreUpdate = -1
    
    var presentAd = false
    
    var activeBidder: Int = Int()
    
//    who won the bid and should make a turn
    
    @IBOutlet weak var whosTurnItIs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlayers()
        setNavigationBarTitle()
        setupScore()
        self.view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 240/255, alpha: 1)
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        textFieldBid.delegate = self
        getPlayers()
        activeBidder = player1
        setupImagesAndCredits()
        
        if scoreUpdate >= 0 {
            resetCredits()
            setupScore()

        }
        
        whosTurnItIs.center = CGPoint(x: whosTurnItIs.center.x + 500, y: whosTurnItIs.center.y)
        
    }
    
    func getPlayers() {
        
        player1 = UserDefaults.standard.object(forKey: "player1") as! Int
        player2 = UserDefaults.standard.object(forKey: "player2") as! Int
        
    }
    func resetCredits() {
        
        switch player1 {
        case 1:
            labelWhosTurn.text = " Xs make your bid: "
            UserDefaults.standard.set(100, forKey: "playerXCredits")
            UserDefaults.standard.set(100, forKey: "playerOCredits")
    
        case 2:
            labelWhosTurn.text = " Os make your bid: "
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

    func presentLabel(text: String) {
        
        self.whosTurnItIs.text = text
        UIView.animate(withDuration: 0.5) {
            self.whosTurnItIs.center = CGPoint(x: self.whosTurnItIs.center.x - 500, y: self.whosTurnItIs.center.y)
        }
    }
    
    func setupImagesAndCredits() {
        
        if player1 == 1 {
            
            labelWhosTurn.text = " Xs make your bid: "
            player1Image.image = UIImage(named: "crosses.png")
            player2Image.image = UIImage(named: "Noughts.png")
            
            player1CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerXCredits")!)
            player2CreditsLabel.text = String(describing: UserDefaults.standard.object(forKey: "playerOCredits")!)

        } else {
            
            labelWhosTurn.text = " Os make your bid: "
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
    
    func setNavigationBarTitle() {
        
        navigationItem.hidesBackButton = true
        
        let image = #imageLiteral(resourceName: "Logo")
        let logo = UIImageView(image: image)
        
        let bannerWidth = navigationController!.navigationBar.frame.size.width
        let bannerHeight = navigationController!.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        logo.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight - 5)
        logo.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = logo
        
    }
    
    @IBAction func bidButton(_ sender: Any) {
        
        
        let playerXCredits = UserDefaults.standard.object(forKey: "playerXCredits") as! Int
        let playerOCredits = UserDefaults.standard.object(forKey: "playerOCredits") as! Int

        
        if textFieldBid.text != "" {
            let bid = Int(textFieldBid.text!)!
            
            switch activeBidder {
            case 1:
                if bid <= playerXCredits {
                    
                    bidX = bid
                    activeBidder = 2
                    textFieldBid.text = ""
                    labelWhosTurn.text = " Os make your bid: "
                    
                } else {
                    //                    not enough credits
                    self.alertMessage(title: "Not enough credits", message: "Try again")
                }
            case 2:
                
                if bid <= playerOCredits {
                    
                    bidO = bid
                    activeBidder = 1
                    textFieldBid.text = ""
                    labelWhosTurn.text = " Xs make your bid: "

                    
                } else {
                    //                    not enough credits
                    self.alertMessage(title: "Not enough credits", message: "Try again")
                    
                }
                    
                    default:
                    break
                
                
                
            }

        }
        
//        check if you have two bids to compare
        
        if bidX >= 0 && bidO >= 0 {
            
            if bidX > bidO {
                
//                x won
                playerOnMove = 1
                UserDefaults.standard.set(playerXCredits - bidX, forKey: "playerXCredits")
                UserDefaults.standard.set(playerOCredits + bidX, forKey: "playerOCredits")
                presentLabel(text: "Xs on move!")
                perform(#selector(callSegue), with: nil, afterDelay: 0.8)
                
            } else if bidX < bidO {
                
//                o won
                playerOnMove = 2
                UserDefaults.standard.set(playerXCredits + bidO, forKey: "playerXCredits")
                UserDefaults.standard.set(playerOCredits - bidO, forKey: "playerOCredits")
                presentLabel(text: "Os on move!")
                perform(#selector(callSegue), with: nil, afterDelay: 0.8)
            } else {
                
//                tie
                bidO = -1
                bidX = -1
                alertMessage(title: "The bid was tie", message: "Go again")
                
            }
            
        }
        
    }
    
    func callSegue() {
        
        performSegue(withIdentifier: "makeMove", sender: nil)
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
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        resetScore()
        setupScore()
        resetCredits()
        setupImagesAndCredits()
    }
}

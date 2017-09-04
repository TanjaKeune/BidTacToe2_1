//
//  TicTacViewController.swift
//  BidTacToe2
//
//  Created by Tanja Keune on 9/1/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TicTacViewController: UIViewController, GADInterstitialDelegate {

    var interstitial: GADInterstitial!
    
    var playerOnMove = 0
    
    var winner = -1         //game tied 0, 1 - x won, 2 - o won, -1 game still on
    
    @IBOutlet weak var whosTurnLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButtonOutlet: UIButton!
    
    
    var gameState = Array(repeating: 0, count: 9)
    
    var winningCombitnation = [[2, 4, 6], [0,4,8], [0, 1, 2], [0,3,6], [1, 4, 7], [2, 5 , 8], [3, 4, 5], [6, 7, 8]]
    
    var complitedTurn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        interstitial = createAndLoadInterstitial()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showInterstitial), name:NSNotification.Name(rawValue: "showInterAd"), object: nil)
    }

    
//    TODO: Interstitial ad is adding +1 on the core variable
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setLabel()

        gameState = UserDefaults.standard.object(forKey: "gameState") as! Array
        updateBoard()
        complitedTurn = false
        
        hideWinningLabelAndButton()
        
        print(gameState)
    }

    func showWinningLabelAndButton() {
        
        UIView.animate(withDuration: 0.5) { 
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x - 500, y: self.winnerLabel.center.y)
            
            self.playAgainButtonOutlet.center = CGPoint(x: self.playAgainButtonOutlet.center.x - 500, y: self.playAgainButtonOutlet.center.y)
        }
    }
    func hideWinningLabelAndButton() {
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x + 500, y: winnerLabel.center.y)
        
        playAgainButtonOutlet.center = CGPoint(x: playAgainButtonOutlet.center.x + 500, y: playAgainButtonOutlet.center.y)
        
    }
    func updateBoard() {
        
        var button: UIButton = UIButton()
        
        for i in 1...9 {
            
            button = self.view.viewWithTag(i) as! UIButton!
            if gameState[i-1] == 1 {
                
                button.setImage((UIImage(named: "crosses.png")?.withRenderingMode(.alwaysOriginal)), for: [])
                
            } else if gameState[i-1] == 2 {
                
                button.setImage((UIImage(named: "noughts.png"))?.withRenderingMode(.alwaysOriginal), for: [])
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabel() {
        
        if playerOnMove == 1 {
            
            self.whosTurnLabel.text = " X Make Your Move "
        } else {
            self.whosTurnLabel.text = " O Make Your Move "
        }

    }

    func setupNavBar() {
        
        self.navigationItem.hidesBackButton = true
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        logo.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        logo.contentMode = .scaleAspectFit
        
        navigationItem.titleView = logo
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
                
//        TODO: Integrate ad's
        
        if !complitedTurn {
            
            complitedTurn = true
            
            let movePlaced = sender.tag - 1
            
            
            if gameState[movePlaced] == 0 {
                
                gameState[movePlaced] = playerOnMove
                
                UserDefaults.standard.set(gameState, forKey: "gameState")
                
                if playerOnMove == 1 {
                    //                place an x
                    sender.setImage(UIImage(named: "crosses.png")?.withRenderingMode(.alwaysOriginal), for: [])
                } else {
                    //                place an o
                    sender.setImage(UIImage(named: "noughts.png")?.withRenderingMode(.alwaysOriginal), for: [])
                    
                }
                
            } else {
                
                //            present alert to choose diffrent position
                
                alertMessage(title: "Position taken", message: "Choose empty field")
            }
            
            //        check if we have a winner or the game is over and set the winner
            
            for combination in winningCombitnation {
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]]  {
                    
                    //                we have a winner
                    
                    if winner < 0 {
                        winner = gameState[combination[0]]
                        
                        if winner == 1 {
                            
                            winnerLabel.text = " X Won!"
                            
//                            change the winning combination images
                            
                            changeWinningImages(winningButtons: combination, winner: 1)
//                            update the score
                            let score = (UserDefaults.standard.object(forKey: "playerXScore") as! Int) + 1
                            UserDefaults.standard.set(score, forKey: "playerXScore")
                            
                        } else {
                            
                            winnerLabel.text = " O Won!"
                            
//                            change the winning combination images
                            changeWinningImages(winningButtons: combination, winner: 2)
                            let score = (UserDefaults.standard.object(forKey: "playerOScore") as! Int) + 1
                            UserDefaults.standard.set(score, forKey: "playerOScore")

                        }
                        resetGameState()
                        
                        //                call winner label
                        
                        showWinningLabelAndButton()
                        break
                    }
                    
                }
                
            }
            
            var emptyPosition = false
            
            for position in gameState {
                
                if position == 0 {
                    
                    emptyPosition = true
                }
            }
            
            if !emptyPosition && winner < 0 {
                
                winner = 0
//                we have a tie
                winnerLabel.text = "This game is a tie!"
                resetGameState()
                showWinningLabelAndButton()
                
            }
            if winner < 0 && complitedTurn {
                
                self.perform(#selector(callSegue), with: nil, afterDelay: 2.0)

            }
        }
        
    }
    
    
    func changeWinningImages(winningButtons: [Int], winner: Int) {
        
        
        var buttonWin: UIButton = UIButton()
        print(winningButtons)
        for i in winningButtons {
            
            let tag = i + 1
            
            buttonWin = view.viewWithTag(tag) as! UIButton!
            
            if gameState[i] == 1 {
                
//                buttonWin.tintColor = UIColor.red

                buttonWin.setImage((UIImage(named: "crossesWon.png")?.withRenderingMode(.alwaysOriginal)), for: [])
                
            } else if gameState[i] == 2 {
                
//                buttonWin.tintColor = UIColor.red
                
                buttonWin.setImage((UIImage(named: "noughtsWon.png")?.withRenderingMode(.alwaysOriginal)), for: [])
                
            }
        }
    }
    
    
    func resetGameState() {
        
        let gameState = Array(repeating: 0, count: 9)
        
        UserDefaults.standard.set(gameState, forKey: "gameState")
        
        UserDefaults.standard.set(100, forKey: "playerXCredits")
        UserDefaults.standard.set(100, forKey: "playerOCredits")

    }
    func callSegue() {
        
        performSegue(withIdentifier: "goBid", sender: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goBid" {
            
            let destination = segue.destination as! BidViewController
            
            destination.scoreUpdate = winner
            
        }
    }
    

    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        
        self.perform(#selector(callSegue), with: nil, afterDelay: 2.0)
        self.perform(#selector(showAd), with: nil, afterDelay: 2.5)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        print("making ad")
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-2556933997218061/3991155796")
        interstitial.delegate = self as GADInterstitialDelegate
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
        return interstitial
    }
    
    func showInterstitial(){
        if (interstitial!.isReady) {
            self.interstitial.present(fromRootViewController: self)
        }else{
            print("ad not ready?")
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func showAd() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInterAd"), object: nil)
        performSegue(withIdentifier: "goBid", sender: nil)
    }
}

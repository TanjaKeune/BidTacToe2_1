//
//  TicTacViewController.swift
//  BidTacToe2
//
//  Created by Tanja Keune on 9/1/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit

class TicTacViewController: UIViewController {

    var playerOnMove = 0
    
    var winner = -1         //game tied 0, 1 - x won, 2 - o won, -1 game still on
    
    @IBOutlet weak var whosTurnLabel: UILabel!
    
    var gameState = Array(repeating: 0, count: 9)
    
    var winningCombitnation = [[2, 4, 6], [0,4,8], [0, 1, 2], [0,3,6], [1, 4, 7], [2, 5 , 8], [3, 4, 5], [6, 7, 8]]
    
    var complitedTurn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setLabel()

        gameState = UserDefaults.standard.object(forKey: "gameState") as! Array
        updateBoard()
        complitedTurn = false
        print(gameState)
        
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
                    
//                    setWinninImages(combination: combination,winner: gameState[combination[0]])
                    winner = gameState[combination[0]]
                    resetGameState()
                    
                    //                call winner label
                }
            }
            
            self.perform(#selector(callSegue), with: nil, afterDelay: 2.0)
        }
        
    }
    
//    func setWinninImages(combination: [Int], winner: Int) {
//        
//        
//        var button: UIButton = UIButton()
//        
//        for i in combination {
//            
//            button = self.view.viewWithTag(i) as! UIButton!
//            
//            if gameState[i-1] == 1 {
//                
//                button.setImage((UIImage(named: "crosses.png")?.withRenderingMode(.alwaysOriginal)), for: [])
//                
//            } else if gameState[i-1] == 2 {
//                
//                button.setImage((UIImage(named: "noughts.png"))?.withRenderingMode(.alwaysOriginal), for: [])
//                
//            }
//        }
//    }
//    
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
            
//            if we have a winner or the game is still on for next bid, and should we add to the score
            
//            destination.gotWinner = winner
        }
    }
    

    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

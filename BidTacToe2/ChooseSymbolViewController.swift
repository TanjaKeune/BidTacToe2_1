//
//  ChooseSymbolViewController.swift
//  BidTacToe2
//
//  Created by Tanja Keune on 9/1/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit

class ChooseSymbolViewController: UIViewController {

    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        UserDefaults.standard.set(0, forKey: "player1")
//        UserDefaults.standard.set(0, forKey: "player2")
        setNavigationBarTitle()
        self.view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 240/255, alpha: 1)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setPlayers(player1: 0, player2: 0)
        
//        print(" player 1: \(UserDefaults.standard.object(forKey: "player1")!) player2: \(UserDefaults.standard.object(forKey: "player1")!)")
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setNavigationBarTitle() {
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        logo.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        logo.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = logo
        
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
     
//        1 - x, 2 - o
        
        if sender.tag == 1 {

            setPlayers(player1: 1, player2: 2)
            
        } else {

            setPlayers(player1: 2, player2: 1)
        }
        
        performSegue(withIdentifier: "gotSymbol", sender: nil)
        
    }
    
    func setPlayers(player1: Int, player2: Int) {
        
        let gameState = Array(repeating: 0, count: 9)
        UserDefaults.standard.set(gameState, forKey: "gameState")
        UserDefaults.standard.set(player1, forKey: "player1")
        UserDefaults.standard.set(player2, forKey: "player2")
        UserDefaults.standard.set(0, forKey: "playerXScore")
        UserDefaults.standard.set(0, forKey: "playerOScore")
        UserDefaults.standard.set(100, forKey: "playerXCredits")
        UserDefaults.standard.set(100, forKey: "playerOCredits")

    }
    
    func setScore() {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotSymbol" {
            
        }
    }
    
}

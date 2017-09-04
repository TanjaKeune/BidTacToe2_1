//
//  ViewController1.swift
//  BidTacToe2
//
//  Created by Tanja Keune on 9/3/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController1: UIViewController, GADInterstitialDelegate {

    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        interstitial = createAndLoadInterstitial()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showInterstitial), name:NSNotification.Name(rawValue: "showInterAd"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBAction func showAd(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showInterAd"), object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

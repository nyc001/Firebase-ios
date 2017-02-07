//
//  ViewController.swift
//  FirebaseFirstLook-iOS
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    // Constant values for use with Remote Config
    let promoEnabledKey = "promo_enabled";
    let promoMsgKey = "promo_message";
    
    @IBOutlet weak var btnPromo: UIButton!
    @IBOutlet weak var txtStatus: UITextField!
    
    // TODO: declare Remote Config variable
	var remoteConfig:FIRRemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // TODO: Create the remote config instance
		remoteConfig=FIRRemoteConfig.remoteConfig();
        
        // TODO: Set up remote config to work in developer mode
		let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true);
		remoteConfig.configSettings=remoteConfigSettings!;
        
        // TODO: load the application default values from the Properties List file
		remoteConfig.setDefaultsFromPlistFileName("RCSettings");
        
        // TODO: Check to see if the Promo button should be displayed
        checkPromoEnabled();
    }

    func checkPromoEnabled() {
        // Set the cache expiration time to 1 hour
        var cacheExpireTime = 3600;
        // TODO: But when we're in developer mode, set expiration to 0
        // so that requests always use the live server
		if (remoteConfig.configSettings.isDeveloperModeEnabled) {
			cacheExpireTime=0;
		}
    
        
        // TODO: Try to fetch the default values from the server
		remoteConfig.fetch(withExpirationDuration: TimeInterval(cacheExpireTime)){
			(status,error)-> Void in
			if (status == FIRRemoteConfigFetchStatus.success ){
				print("Successful fetch")
				self.remoteConfig.activateFetched();
			}else{
				print("Error fetch remot settings");
				print("Error \(error!.localizedDescription)");
			}
			self.showPromoButton();
		}
    }
    
    func showPromoButton() {
        // TODO: Use the values from remote config to see if the Promo button
        // Should be visible and what the button title should be
        let showBtn = remoteConfig[promoEnabledKey].boolValue;
        let promoMsg = remoteConfig["welcome_message"].stringValue;
		
     
        // TODO: use the results to set the button properties
        self.btnPromo.setTitle(promoMsg, for: UIControlState());
        self.btnPromo.isHidden = !showBtn;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Log events for each of the Button taps in the UI
    @IBAction func btn1Tap(_ sender: AnyObject) {
        txtStatus.text = "Button 1 Tapped";
        
        // TODO: Record button tap
		FIRAnalytics.logEvent(withName: "Button1Click", parameters: nil)
    }
    
    @IBAction func btn2Tap(_ sender: AnyObject) {
        txtStatus.text = "Button 2 Tapped";
        
        // TODO: Record button tap
		FIRAnalytics.logEvent(withName: "Button2Click", parameters: nil)
    }
    
    @IBAction func btnAuthTap(_ sender: AnyObject) {
        txtStatus.text = "Button Auth Tapped";
        
        // TODO: Record button tap
		FIRAnalytics.logEvent(withName: "ButtonAuthClick", parameters: nil)
    }
    
    @IBAction func btnPromoTap(_ sender: AnyObject) {
        txtStatus.text = "Button Promo Tapped";
        
        // TODO: Record button tap
		FIRAnalytics.logEvent(withName: "ButtonPromoClick", parameters: nil)
    }
}


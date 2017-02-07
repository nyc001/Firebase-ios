//
//  EcommViewController.swift
//  FirebaseFirstLook-iOS
//

import UIKit
import Firebase

class EcommViewController: UIViewController {

    @IBAction func didTapBuy(_ sender: AnyObject) {
        // TODO: When the user taps the Buy button record a fictional ecommerce purchase
		FIRAnalytics.logEvent(withName: kFIREventEcommercePurchase, parameters: [kFIRParameterItemID:"Promo Item" as NSObject])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: record this view opening as an ecommerce "view item" event
		FIRAnalytics.logEvent(withName: kFIREventViewItem, parameters: [kFIRParameterItemID:"Promo Item" as NSObject])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

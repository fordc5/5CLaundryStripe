//
//  homeViewController.swift
//  5CLaundry
//
//  Created by Connor Ford on 5/30/17.
//  Copyright © 2017 5CLaundry. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    @IBOutlet weak var roundedCornerAbout: UIButton!
    @IBOutlet weak var roundedCornerContact: UIButton!
    @IBOutlet weak var roundedCornerDeliverySchedule: UIButton!
    @IBOutlet weak var roundedCornerLaundryPlans: UIButton!
    @IBOutlet weak var roundedCornerMyAccount: UIButton!
    @IBOutlet weak var roundedCornerFAQ: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: Segue with Code Approach
    
    @IBAction private func toAbout(_ sender: UIButton) {
        performSegue(withIdentifier: "toAbout", sender: sender)
    }
    
    @IBAction private func toContact(_ sender: UIButton) {
        performSegue(withIdentifier: "toContact", sender: sender)
    }
    
    @IBAction private func toFAQ(_ sender: UIButton) {
        performSegue(withIdentifier: "toFAQ", sender: sender)
    }
    
    @IBAction private func toDeliverySchedule(_ sender: UIButton) {
        performSegue(withIdentifier: "toDeliverySchedule", sender: sender)
    }
    
    @IBAction private func toPageViewController(_ sender: UIButton) {
        performSegue(withIdentifier: "toPageViewController", sender: sender)
    }

}


//
//  ViewController.swift
//  SampleApp
//
//  Created by Downey, Eric on 11/14/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import UIKit
import GameplayKit

class RNGViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var startField: UITextField?
    @IBOutlet var endField: UITextField?
    @IBOutlet var resultLabel: UILabel?
    
    // MARK: - Properties
    
    lazy var alertCtrl: UIAlertController = {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid start number and end number", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
        return alert
    }()
    
    
    // MARK: - Actions
    
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func generateNumber() {
        dismissKeyboard()
        guard let lower = startField?.text?.integer, let upper = endField?.text?.integer else {
            showErrorAlert()
            return
        }
        let distribution = GKRandomDistribution(lowestValue: lower, highestValue: upper)
        resultLabel?.text = "Result: \(distribution.nextInt())"
    }
    
    private func showErrorAlert() {
        present(alertCtrl, animated: UIView.areAnimationsEnabled, completion: nil)
    }
}

extension String {
    var integer: Int? {
        return Int(self)
    }
}


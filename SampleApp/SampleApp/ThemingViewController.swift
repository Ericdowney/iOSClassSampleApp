//
//  ThemingViewController.swift
//  SampleApp
//
//  Created by Downey, Eric on 11/14/16.
//  Copyright © 2016 Eric Downey. All rights reserved.
//

import UIKit

enum Theme {
    case light
    case dark
    
    var color: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .darkGray
        }
    }
    
    var opposite: Theme {
        switch self {
        case .light:
            return .dark
        case .dark:
            return .light
        }
    }
}

protocol Themeable {
    func apply(theme: Theme)
}

class Button: UIButton, Themeable {
    func apply(theme: Theme) {
        setTitleColor(theme.opposite.color, for: .normal)
    }
}

class Label: UILabel, Themeable {
    func apply(theme: Theme) {
        textColor = theme.opposite.color
        backgroundColor = theme.color
    }
}

class View: UIView, Themeable {
    func apply(theme: Theme) {
        backgroundColor = theme.color
    }
}

extension UIViewController {
    @IBAction func dismiss() {
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}

class ThemingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var stepLabel: Label?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apply(theme: .light)
    }
    
    // MARK: - Alerts
    
    @IBAction func presentAlert() {
        presentAlert(with: .alert)
    }
    
    @IBAction func presentActionSheet() {
        presentAlert(with: .actionSheet)
    }
    
    private func presentAlert(with style: UIAlertControllerStyle) {
        let alert = UIAlertController(title: "Test Alert", message: "This is a message", preferredStyle: style)
        
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
        alert.addAction( UIAlertAction(title: "Action 1", style: .default, handler: nil) )
        
        present(alert, animated: UIView.areAnimationsEnabled, completion: nil)
    }
    
    // MARK: - Switch
    
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.isOn {
            apply(theme: .dark)
        }
        else {
            apply(theme: .light)
        }
    }
    
    private func apply(theme: Theme) {
        ([view] + view.subviews).map { subview in
            subview as? Themeable
        }.forEach { element in
            element?.apply(theme: theme)
        }
    }
    
    // MARK: - Stepper
    
    @IBAction func stepperChanged(sender: UIStepper) {
        stepLabel?.text = "Step: \(sender.value)"
    }
}

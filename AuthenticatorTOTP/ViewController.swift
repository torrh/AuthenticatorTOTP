//
//  ViewController.swift
//  AuthenticatorTOTP
//
//  Created by HAWER TORRES on 3/11/19.
//  Copyright © 2019 HAWER TORRES. All rights reserved.
//

import UIKit
import SwiftOTP

class ViewController: UIViewController {
    
    private var timer: Timer?
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var passcodeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updatePasscode()
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updatePasscode), userInfo: nil, repeats: true)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    @objc func appMovedToBackground() {
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func animateProgressView() {
        self.progressView.setProgress(1.0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progressView.setProgress(0.0, animated: false)
            UIView.animate(withDuration: 30, delay: 0, options: [], animations: { [unowned self] in
                self.progressView.layoutIfNeeded()
            })
        }
    }
    
    @objc func updatePasscode() {
        let randomString = TOTPHelper.randomString(length: 16)
        
        guard let randomStringData = TOTPHelper.randomStringData(randomString: randomString), let dataEncoded = TOTPHelper.dataBase32Encode(data: randomStringData), let data = TOTPHelper.factorSecretData(factorSecret: dataEncoded) else { return }
        
        let passcode = TOTPHelper.getTOTPObject(data: data)
        passcodeLabel.text = passcode
        
        animateProgressView()
        
    }
}


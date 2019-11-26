//
//  ViewController.swift
//  HiddenCam
//
//  Created by Daniel on 26/11/2019.
//  Copyright © 2019 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let buttonGood = UIButton()
    let buttonEvil = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonGood.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        buttonGood.backgroundColor = UIColor.blue
        buttonGood.layer.masksToBounds = true
        buttonGood.setTitle("capture with viewfinder", for: .normal)
        buttonGood.setTitleColor(UIColor.white, for: .normal)
        buttonGood.layer.cornerRadius = 20.0
        buttonGood.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        buttonGood.addTarget(self, action: #selector(self.buttonGoodClick(sender:)), for: .touchUpInside)
        
        self.view.addSubview(buttonGood)
        
        buttonEvil.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        buttonEvil.backgroundColor = UIColor.blue
        buttonEvil.layer.masksToBounds = true
        buttonEvil.setTitle("capture with viewfinder", for: .normal)
        buttonEvil.setTitleColor(UIColor.white, for: .normal)
        buttonEvil.layer.cornerRadius = 20.0
        buttonEvil.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        buttonEvil.addTarget(self, action: #selector(self.buttonEvilClick(sender:)), for: .touchUpInside)
        
        self.view.addSubview(buttonEvil)
        
    }
    
    @objc func buttonGoodClick(sender: UIButton) {
        self.show(CameraViewController(), sender: self)
    }

    @objc func buttonEvilClick(sender: UIButton) {

    }

}


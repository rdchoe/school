//
//  ViewController.swift
//  Volvo_Pmml
//
//  Created by Robert Choe on 7/16/18.
//  Copyright © 2018 Volvo Group. All rights reserved.
//

import UIKit
import WebKit
class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func bt10pressed(_ sender: Any) {
        print("bt10 pressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "bt10ViewController")as! bt10ViewController
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    
  
    @IBOutlet weak var MAINBUTTON: UIButton! {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


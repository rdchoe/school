//
//  bt10yfftViewController.swift
//  Volvo_Pmml
//
//  Created by Robert Choe on 7/19/18.
//  Copyright © 2018 Volvo Group. All rights reserved.
//

import UIKit
import WebKit

class bt10yfftViewController: UIViewController {
    
 
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func back_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "bt10ViewController")as! bt10ViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let htmlPath = Bundle.main.path(forResource: "bt10_drive_y_dash", ofType: "html")
        // let folderPath = Bundle.main.bundlePath
        let baseUrl = URL(fileURLWithPath: htmlPath!)
        let request = URLRequest(url: baseUrl )
        webView.load(request )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        navigationItem.hidesBackButton = true
        // Dispose of any resources that can be recreated.
    }
    
    
}

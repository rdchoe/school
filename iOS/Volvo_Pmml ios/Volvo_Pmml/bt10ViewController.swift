//
//  bt_10ViewController.swift
//  Volvo_Pmml
//
//  Created by Robert Choe on 7/17/18.
//  Copyright © 2018 Volvo Group. All rights reserved.
//


import UIKit
import WebKit
class bt10ViewController: UIViewController {
    

    @IBOutlet weak var webView_ftf: WKWebView!
    @IBOutlet weak var webView_bsf: WKWebView!
    @IBOutlet weak var webView_bpfi: WKWebView!
    @IBOutlet weak var webView_bpfo: WKWebView!
    
    @IBAction func back_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    @IBAction func x_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "bt10xfftViewController")as! bt10xfftViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    @IBAction func y_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "bt10yfftViewController")as! bt10yfftViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func z_pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "bt10zfftViewController")as! bt10zfftViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ftf_path = Bundle.main.path(forResource: "bt10_ftf", ofType: "html")
        let bsf_path = Bundle.main.path(forResource: "bt10_bsf", ofType: "html")
        let bpfi_path = Bundle.main.path(forResource: "bt10_bpfi", ofType: "html")
        let bpfo_path = Bundle.main.path(forResource: "bt10_bpfo", ofType: "html")
        
        let ftf_baseUrl = URL(fileURLWithPath: ftf_path!)
        let bsf_baseUrl = URL(fileURLWithPath: bsf_path!)
        let bpfi_baseUrl = URL(fileURLWithPath: bpfi_path!)
        let bpfo_baseUrl = URL(fileURLWithPath: bpfo_path!)
        
        let ftf_request = URLRequest(url: ftf_baseUrl )
        let bsf_request = URLRequest(url: bsf_baseUrl )
        let bpfi_request = URLRequest(url: bpfi_baseUrl )
        let bpfo_request = URLRequest(url: bpfo_baseUrl )
        
        webView_ftf.load(ftf_request)
        webView_bsf.load(bsf_request)
        webView_bpfi.load(bpfi_request)
        webView_bpfo.load(bpfo_request)
        
        print("bt10 view controller has loaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        navigationItem.hidesBackButton = true
        // Dispose of any resources that can be recreated.
    }
    
    
}

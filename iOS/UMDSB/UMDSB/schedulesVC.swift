//
//  schedulesVC.swift
//  UMDSB
//
//  Created by Robert Choe on 3/29/18.
//  Copyright © 2018 Robert Choe. All rights reserved.
//

import UIKit

class schedulesVC: UIViewController {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    var schedules: Array<Schedule>!
    
    let viewWidth: CGFloat = 200
    let viewHeight: CGFloat = 100
    var yPosition: CGFloat = 0
    var scrollViewContentSize: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 0..<schedules.count {
            let currSchedule = schedules[i]
            let schedView: UIImageView = UIImageView()
            let myImage: UIImage = UIImage(named: "turtle.png")!
            schedView.image = myImage
            
            
            schedView.frame.size.width = viewWidth
            schedView.frame.size.height = viewHeight
            schedView.frame.origin.x = 10
            schedView.frame.origin.y = yPosition
            
            myScrollView.addSubview(schedView)
            
            yPosition += viewHeight
            scrollViewContentSize += viewHeight
            
            myScrollView.contentSize = CGSize(width: viewWidth, height: scrollViewContentSize)
        }
        
        
    }
    
    
}


    

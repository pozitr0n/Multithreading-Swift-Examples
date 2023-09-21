//
//  TwoViewController.swift
//  Lesson_9
//
//  Created by Raman Kozar on 20/09/2023.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myInactiveQueue()
        
    }
    
    func myInactiveQueue() {
        
        let inactiveQueue = DispatchQueue(label: "My Personal Queue",
                                          attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Ready!")
        }
        
        print("Not yet started...")
        inactiveQueue.activate()
        print("Activate!")
        inactiveQueue.suspend()
        print("Pause!")
        inactiveQueue.resume()
        
    }
    
    func myConcurrentPerform() {
        
        //        for i in 0...2000000 {
        //            print(i)
        //        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            
            DispatchQueue.concurrentPerform(iterations: 2000000) { i in
                print(i)
                print(Thread.current)
            }
            
        }
        
    }

}

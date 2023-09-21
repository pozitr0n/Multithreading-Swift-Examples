//
//  ViewController.swift
//  Lesson_9
//
//  Created by Raman Kozar on 20/09/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        afterBlock(seconds: 2, queue: .main) {
//            print("Hello")
//            print(Thread.current)
//        }
        
        afterBlock(seconds: 2, queue: .main) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        }

    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: nil, message: "Hello, world!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completeion: @escaping() -> ()) {
        
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completeion()
        }
        
    }

}


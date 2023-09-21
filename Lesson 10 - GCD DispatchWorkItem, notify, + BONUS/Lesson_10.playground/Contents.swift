import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Dispatch Work item"

class DispatchWorItem1 {
    
    private let queue = DispatchQueue(label: "DispatchWorItem1", attributes: .concurrent)

    func create() {
        
        let workItem = DispatchWorkItem {
            
            print(Thread.current)
            print("Start of the task")
            
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finished")
        }
        
        queue.async(execute: workItem)
        
    }
    
}

let dispatchWorItem1 = DispatchWorItem1()
//dispatchWorItem1.create()

class DispatchWorItem2 {
    
    private let queue = DispatchQueue(label: "DispatchWorItem1")

    func create() {
        
        queue.async {
            
            sleep(1)
            print(Thread.current)
            print("Task 1")
            
        }
        
        queue.async {
            
            sleep(1)
            print(Thread.current)
            print("Task 2")
            
        }
        
        queue.async {
            
            sleep(1)
            print(Thread.current)
            print("Task 3")
            
        }
        
        let workItem = DispatchWorkItem {
            
            print(Thread.current)
            print("Start work item task")
            
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel()
        
    }
    
}

let dispatchWorItem2 = DispatchWorItem2()
//dispatchWorItem2.create()

let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 400))
let bridgeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 600, height: 400))

bridgeImage.backgroundColor = .yellow
bridgeImage.contentMode = .scaleAspectFit

view.addSubview(bridgeImage)

let imageURL = URL(string: "https://sun9-47.userapi.com/impg/7zTg4y1-bjHydaxqOBfT26AGM52lJDgpq4q1VQ/LJOepzwUCBY.jpg?size=1200x1600&quality=96&sign=5c0b5960cc9f767eb115562946ee6cc6&type=album")

// # CLASSIC
func fetchImage() {
    
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        
        guard let imageURL = imageURL else {
            return
        }
        
        if let myData = try? Data(contentsOf: imageURL) {
            
            print(myData)
            
            DispatchQueue.main.async {
                
                bridgeImage.image = UIImage(data: myData)
                
            }
        }
    }
    
}

//fetchImage()
//PlaygroundPage.current.liveView = view

// # Dispatch Work Item
func fetchImage2() {
    
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        
        guard let imageURL = imageURL else {
            return
        }
        
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
        
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: .main) {
        
        if let imageData = data {
            bridgeImage.image = UIImage(data: imageData)
        }
        
    }
    
}

//fetchImage2()
//PlaygroundPage.current.liveView = view

// # URLSession
func fetchImage3() {
    
    guard let imageURL = imageURL else {
        return
    }
    
    let task = URLSession.shared.dataTask(with: imageURL) { (data, Response, Error) in
        
        print(Thread.current)
        if let imageData = data {
            DispatchQueue.main.async {
                
                bridgeImage.image = UIImage(data: imageData)
                
            }
        }
        
    }
    task.resume()
    
}

fetchImage3()
PlaygroundPage.current.liveView = view

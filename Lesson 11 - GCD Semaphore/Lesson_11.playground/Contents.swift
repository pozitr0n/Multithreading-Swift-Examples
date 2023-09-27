import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Semaphores"

let queue = DispatchQueue(label: "My Queue", attributes: .concurrent)

let semaphore = DispatchSemaphore(value:2)

queue.async {
    
    semaphore.wait() // explain: value minus 1          -1
    sleep(1)
    
    print("method 1")
    semaphore.signal() // explain: value plus 1         +1
    
}

queue.async {
    
    semaphore.wait() // explain: value minus 1          -1
    sleep(1)
    
    print("method 2")
    semaphore.signal() // explain: value plus 1         +1
    
}

queue.async {
    
    semaphore.wait() // explain: value minus 1          -1
    sleep(1)
    print("method 3")
    semaphore.signal() // explain: value plus 1         +1
    
}

let sem = DispatchSemaphore(value: 2)

DispatchQueue.concurrentPerform(iterations: 10) { (myInt: Int) in
    
    sem.wait(timeout: DispatchTime.distantFuture)
    sleep(1)
    print("Block", String(myInt))
    sem.signal()
    
}

class MySemaphore {
    
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        
        semaphore.wait()
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 2)
        semaphore.signal()
        
    }
    
    public func startAllThreads() {
        
        DispatchQueue.global().async {
            
            self.methodWork(111)
            print(Thread.current)
            
        }
        
        DispatchQueue.global().async {
            
            self.methodWork(222)
            print(Thread.current)
            
        }
        
        DispatchQueue.global().async {
            
            self.methodWork(333)
            print(Thread.current)
            
        }
        
    }
    
}

let semaphoreTest = MySemaphore()
semaphoreTest.startAllThreads()

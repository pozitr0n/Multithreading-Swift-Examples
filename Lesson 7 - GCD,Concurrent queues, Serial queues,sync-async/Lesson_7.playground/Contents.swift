import UIKit

class QueueTest_SerialConcurrent {
    
    private let serialQueue = DispatchQueue(label: "mySerialQueue")
    private let concurrentQueue = DispatchQueue(label: "myConcurrentQueue", attributes: .concurrent)
    
}

class QueueTest2_GlobalMain {
    
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
    
}

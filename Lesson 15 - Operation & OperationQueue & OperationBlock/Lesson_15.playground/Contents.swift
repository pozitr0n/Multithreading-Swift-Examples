import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Operation and Operation Queue"

print(Thread.current)

//let operation1 = {
//    
//    print("Start")
//    print(Thread.current)
//    print("finish")
//    
//}
//
//let queue = OperationQueue()
//queue.addOperation(operation1)

var result: String?
let concatOperation = BlockOperation {
    result = "The Swift Developers"
    print(Thread.current)
}

//concatOperation.start()

//print(result!)

//let queue = OperationQueue()
//queue.addOperation(concatOperation)
//print(result!)

//let queue1 = OperationQueue()
//queue1.addOperation {
//    print("test")
//    print(Thread.current)
//}

print(Thread.current)

class MyThread: Thread {
    
    override func main() {
        print("Test main thread")
    }
    
}

let myThread = MyThread()
myThread.start()

class OperationA: Operation {
    
    override func main() {
        print("test main 2 thread")
        print(Thread.current)
    }
    
}

let myOperation = OperationA()
//myOperation.start()

let queue2 = OperationQueue()
queue2.addOperation(myOperation)

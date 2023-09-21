import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Operation, part 2"

let operationQueue = OperationQueue()

class OperationCancelTest: Operation {
    
    override func main() {
        
        if isCancelled {
            print(isCancelled)
            return
        }
        
        print("test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        
        print("test 2")
        
    }
    
}

func cancelOperationMethod() {
    
    let cancelOperation = OperationCancelTest()
    operationQueue.addOperation(cancelOperation)
    cancelOperation.cancel()
    
}

//cancelOperationMethod()

class WaitOperationTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        operationQueue.addOperation {
            sleep(1)
            print("test 1")
        }
        
        operationQueue.addOperation {
            sleep(2)
            print("test 2")
        }
        
        //!!!
        operationQueue.waitUntilAllOperationsAreFinished()
        //!!!
        
        operationQueue.addOperation {
            print("test 3")
        }
        
        operationQueue.addOperation {
            print("test 4")
        }
        
    }
    
}

//let waitOperation = WaitOperationTest()
//waitOperation.test()

class WaitOperationTest2 {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        let operation1 = BlockOperation {
            
            sleep(1)
            print("Test 111")
            
        }
        
        let operation2 = BlockOperation {
            
            sleep(4)
            print("Test 222")
            
        }
        
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
        
        let operation3 = BlockOperation {
            
            print("Test 333")
            
        }
        
        operationQueue.addOperation(operation3)
        
    }
    
}

//let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest2.test()


class CompletionBlockTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        
        let operation1 = BlockOperation {
            print("test Completion Block")
        }
        
        operation1.completionBlock = {
            print("finish!")
        }
        operationQueue.addOperation(operation1)
        
    }
    
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()

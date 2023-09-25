import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Barrier"

//var array = [Int]()
//
//for i in 0...9 {
//    array.append(i)
//}

//print(array)
//print(array.count)

//var array1 = [Int]()
//
//DispatchQueue.concurrentPerform(iterations: 10) { (index) in
//    array1.append(index)
//}
//
//print(array1)
//print(array1.count)

class SafeArray<T> {

    private var array = [T]()
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)
    
    public func appendToArray(_ value: T) {
        
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
        
    }
    
    public var valueArray: [T] {
        
        var result = [T]()
        
        queue.sync {
            result = self.array
        }
        
        return result
        
    }
    
}

var arraySafe = SafeArray<Int>()

DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    arraySafe.appendToArray(index)
}

print(arraySafe.valueArray)
print(arraySafe.valueArray.count)



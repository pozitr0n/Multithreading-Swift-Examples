import UIKit

var str = "NSCondition()"

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class ConditionMutexPrinter: Thread {
    
    // "Attempting to initialize an already initialized condition variable results in undefined behavior"
    // Only for studing
    override init() {
        
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
        
    }
    
    override func main() {
        print("This is my class")
        printerMethod()
    }
    
    private func printerMethod() {
        
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        
        while !available {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Printer exit")
        
    }
    
}

class ConditionMutexWriter: Thread {
    
    // "Attempting to initialize an already initialized condition variable results in undefined behavior"
    // Only for studing
    override init() {
        
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
        
    }
    
    override func main() {
        print("This is my class")
        writerMethod()
    }
    
    private func writerMethod() {
        
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        
        pthread_cond_signal(&condition)
        
        available = true
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Writer exit")
        
    }
    
}

let conditionMutexWriter = ConditionMutexWriter()
let conditionMutexPrinter = ConditionMutexPrinter()

conditionMutexPrinter.start()
// sleep(3)
conditionMutexWriter.start()


let condition_1 = NSCondition()
var available_1 = false

class WriterThread: Thread {
    
    override func main() {
        
        condition_1.lock()
        
        print("Into write 1 thread..")
        
        available_1 = true
        
        condition_1.signal()
        condition_1.unlock()
        
        print("Out write 1 thread..")
        
    }
    
}

class PrinterThread: Thread {
    
    override func main() {
        
        condition_1.lock()
        print("Into write 2 thread..")
        
        while !available_1 {
            condition_1.wait()
        }
        
        available_1 = false
        condition_1.unlock()
        
        print("Out write 2 thread..")
        
    }
    
}

let writeT = WriterThread()
let printT = PrinterThread()

printT.start()
writeT.start()

import UIKit

var str = "NSRecursiveLock"

let recursiveThread = NSRecursiveLock()

// Unix. C.

class RecursiveMutexTest {
    
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init() {
        
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
        
    }
    
    func firstTask() {
        
        pthread_mutex_lock(&mutex)
        secondTask()
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
    }
    
    private func secondTask() {
        
        pthread_mutex_lock(&mutex)
        print("Finish")
        
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
    }
    
}

let recursive = RecursiveMutexTest()
recursive.firstTask()

var str1 = "NSRecursiveLock - Objective-C"
let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {
    
    override func main() {
        
        recursiveLock.lock()
        print("Thread locked")
        callMe()
        
        defer {
            recursiveLock.unlock()
        }
        
        print("Thread unlock. Exit main()")
        
    }
    
    func callMe() {
        
        recursiveLock.lock()
        print("Thread locked")
        
        defer {
            recursiveLock.unlock()
        }
        
        print("Thread unlock. Exit callMe()")
        
    }
    
}

let thread = RecursiveThread()
thread.start()


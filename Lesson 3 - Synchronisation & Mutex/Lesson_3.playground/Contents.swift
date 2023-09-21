import UIKit

var str = "Synchronization & Mutex"

class SaveThread {
    
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(completion: ()->()) {
        
        pthread_mutex_lock(&mutex) // блокировка
        
        // some data, some code
        completion()
        
        // если что-то упадет до pthread_mutex_unlock - поток не будет освобожден
        // разблокировка
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
    }
    
}

var array = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    
    print("test")
    array.append("1")
    array.append("2")
    array.append("3")
    
}

array.append("4")


class SaveThreadObjC {
    
    private let lockMutex = NSLock()
    
    func someMethod(completion: ()->()) {
        
        lockMutex.lock()
        completion()
        
        defer {
            lockMutex.unlock()
        }
        
    }
    
}

var array1 = [String]()
let saveThread1 = SaveThreadObjC()

saveThread1.someMethod {
    
    print("test")
    array1.append("1")
    array1.append("2")
    array1.append("3")
    
}

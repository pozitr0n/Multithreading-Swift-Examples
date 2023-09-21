import UIKit

// Thread
// Operation
// GCD

// Параллельная очередь
// 1 Thread -------------
// 2 Thread -------------

// Последовательная очередь
// 1 Thread - - -
// 2 Thread  - - -

// Асинхронная работа
// 1 - Main (UI) ---------
// 2 Thread         --

// UNIX - POSIX система

var thread = pthread_t(bitPattern: 0) // создаем поток
var attribute = pthread_attr_t() // создали атрибут

pthread_attr_init(&attribute) // проинициализировали и создали поток

pthread_create(&thread, &attribute, { pointer in
    
    print("test")
    return nil
    
}, nil)

// 2. Thread (in Objective-C)
var nsthread = Thread {
    print("test")
}

nsthread.start() // запускаем поток

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Dispatch Source"

// "timer" using DispatchSource
let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())

timer.setEventHandler {
    print("Yeah! It's time!")
}

// schedule
timer.schedule(deadline: .now(), repeating: 5)

// activate
timer.activate()

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Dispatch Source"

let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())

timer.setEventHandler {
    print("Yeah! It's time!")
}

timer.schedule(deadline: .now(), repeating: 5)
timer.activate()

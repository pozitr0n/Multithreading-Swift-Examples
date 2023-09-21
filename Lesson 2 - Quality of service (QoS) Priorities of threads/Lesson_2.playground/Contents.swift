import UIKit

var lesson2 = "QoS - Quality of Service - Качество обслуживания"

var pthread = pthread_t(bitPattern: 0)

var attribute = pthread_attr_t()
pthread_attr_init(&attribute)

pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)
pthread_create(&pthread, &attribute, { pointer in
    
    print("test")
    
    // Изменить приоритет
    pthread_set_qos_class_self_np(QOS_CLASS_USER_INTERACTIVE, 0)
    
    return nil
    
}, nil)

// Objective-C
let nsThread = Thread {
    print("Test")
    print(qos_class_self())
}
nsThread.qualityOfService = .utility
nsThread.start()

print(qos_class_self())

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Dispatch Group"

class DispatchGroupTest1 {
    
    private let queueSerial = DispatchQueue(label: "myQueue")
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        
        queueSerial.async(group: groupRed) {
         
            sleep(1)
            print("1")
            
        }
        
        queueSerial.async(group: groupRed) {
         
            sleep(1)
            print("2")
            
        }
        
        groupRed.notify(queue: .main) {
            print(Thread.current)
            print("final")
        }
        
    }
    
}

// let dispatchGroupTest1 = DispatchGroupTest1()
// dispatchGroupTest1.loadInfo()

class DispatchGroupTest2 {
    
    private let queueConcurrent = DispatchQueue(label: "myQueue", attributes: .concurrent)
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        
        groupBlack.enter()
        queueConcurrent.async {
            
            sleep(1)
            print("task 1")
            self.groupBlack.leave()
            
        }
        
        groupBlack.enter()
        queueConcurrent.async {
            
            sleep(2)
            print("task 2")
            self.groupBlack.leave()
            
        }
        
        groupBlack.wait()
        print("finish all")
        
        groupBlack.notify(queue: .main) {
            print("all the groups finished")
        }
        
    }
    
}

// let dispatchGroupTest2 = DispatchGroupTest2()
// dispatchGroupTest2.loadInfo()

class EightImage: UIView {
        
    public var picArray = [UIImageView]()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        picArray.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        picArray.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        picArray.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            picArray[i].contentMode = .scaleAspectFit
            self.addSubview(picArray[i])
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let view = EightImage(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .red

let imageURLs = ["https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "https://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "https://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png", "https://adangles.com/arctic/arctic-12.jpg"]

var images = [UIImage]()

func asyncLoadImage(imageURL: URL,
                    queue: DispatchQueue, 
                    completionQueue: DispatchQueue,
                    complition: @escaping(UIImage?, Error?) -> ()) {
    
    queue.async {
        
        do {
            
            let data = try Data(contentsOf: imageURL)
            
            completionQueue.async {
                complition(UIImage(data: data), nil)
            }
            
        } catch let error {
            
            completionQueue.async {
                complition(nil, error)
            }
            
        }
        
    }
    
}

func asyncGroup() {
    
    let aGroup = DispatchGroup()
    
    for i in 0...3 {
    
        aGroup.enter()
        
        guard let currStrUrl = URL(string: imageURLs[i]) else {
            return
        }
        
        asyncLoadImage(imageURL: currStrUrl,
                       queue: .global(),
                       completionQueue: .main) { (resultImage, error) in
            
            if let image1 = resultImage {
                images.append(image1)
            }
            
            aGroup.leave()
            
        }
        
    }
    
    aGroup.notify(queue: .main) {
        
        for i in 0...images.count - 1 {
            view.picArray[i].image = images[i]
        }
        
    }
    
}

func asyncURLSession() {
    
    for i in 4...7 {
        
        let url = URL(string: imageURLs[i - 4])
        
        guard let url = url else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                view.picArray[i].image = UIImage(data: data!)
                
            }
        
        }.resume()
        
    }
    
}

PlaygroundPage.current.liveView = view

//asyncGroup()
asyncURLSession()


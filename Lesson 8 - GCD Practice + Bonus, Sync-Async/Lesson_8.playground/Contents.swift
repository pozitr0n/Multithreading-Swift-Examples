import UIKit
import PlaygroundSupport

//var str = "GCD"

class MyViewController: UIViewController {
    
    let myButton = UIButton()
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .gray
        myButton.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
        
    }
    
    @objc func pressAction() {
        let vcNew = MyViewControllerNew()
        navigationController?.pushViewController(vcNew, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        initLabel()
        initButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.label.center = CGPoint(x: 400.0, y: 50.0)
    }
    
    func initLabel() {
        
        label.text = "This is my VC"
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
    }
    
    func initButton() {
        
        myButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        myButton.center = CGPoint(x: 400.0, y: 450.0)
        myButton.setTitle("Press me", for: .normal)
        myButton.backgroundColor = .red
        myButton.setTitleColor(.white, for: .normal)
        myButton.layer.cornerRadius = 10
        
        view.addSubview(myButton)
        
    }
    
}

class MyViewControllerNew: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
    let image = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        
//        let imageURL: URL = URL(string: "https://static.wikia.nocookie.net/edm/images/9/92/Armin_van_Buuren.jpg/revision/latest?cb=20141003011725&path-prefix=es")!
//
//        if let data = try? Data(contentsOf: imageURL) {
//            self.image.image = UIImage(data: data)
//        }
        loadPhoto()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        initLabel()
        initImage()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.label.center = CGPoint(x: 400.0, y: 50.0)
    }
    
    func initLabel() {
        
        label.text = "This is Armin van Buuren"
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
    }
    
    func initImage() {
        
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
        
    }
    
    func loadPhoto() {
     
        let imageURL: URL = URL(string: "https://static.wikia.nocookie.net/edm/images/9/92/Armin_van_Buuren.jpg/revision/latest?cb=20141003011725&path-prefix=es")!
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            
            if let data = try? Data(contentsOf: imageURL) {
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
                
            }
            
        }
        
    }

}

let myVC = MyViewController()
let navBar = UINavigationController(rootViewController: myVC)

PlaygroundPage.current.liveView = navBar

//
//  findViewController.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/8/27.
//

import UIKit

class findViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let cycleScrollView = MYCycleScrollView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: 300))
        cycleScrollView.imageURLs = [ "https://s3.bmp.ovh/imgs/2021/08/c36e908c93e0fa1e.png",
                                       "https://i.bmp.ovh/imgs/2021/08/03970bbfaf60b395.gif",
                                        "https://s3.bmp.ovh/imgs/2021/08/23403d5a47e77e66.png"]
        cycleScrollView.autoScrollTimeInterval = 5
        cycleScrollView.imageViewContentMode = .scaleAspectFill
        cycleScrollView.delegate = self
        
    
        
//        let imageClickTap = UIGestureRecognizer(target: self, action: #selector(imageClick))
//        cycleScrollView.addGestureRecognizer(imageClickTap)
        
    
        
        self.view.addSubview(cycleScrollView)
        
        
        let microData = NSData(contentsOf: URL(string: "https://s3.bmp.ovh/imgs/2021/08/c36e908c93e0fa1e.png")!)
        let microImage = UIImage(data: microData! as Data)
        microCourseImage.image = microImage
//        let singleGesture = UITapGestureRecognizer(target: self, action: #selector(imageClick))
//        microCourseImage?.addGestureRecognizer(singleGesture)
//        microCourseImage?.isUserInteractionEnabled = true
      
        
        let liveData = NSData(contentsOf: URL(string: "https://i.bmp.ovh/imgs/2021/08/03970bbfaf60b395.gif")!)
        let liveImage = UIImage(data: liveData! as Data)
        liveCourseImage.image = liveImage
        
        let mvData = NSData(contentsOf: URL(string: "https://s3.bmp.ovh/imgs/2021/08/23403d5a47e77e66.png")!)
        let mvImage = UIImage(data: mvData! as Data)
        MVImage.image = mvImage

     
        
        // Do any additional setup after loading the view.
    }
    
//    @objc func imageClick() {
//        print("image clicked")
//        let videoPlayerViewController = videoPlayerViewController()
//        self.navigationController?.pushViewController(videoPlayerViewController, animated: true)
//    }
    
    @IBOutlet weak var cycleScrollView: MYCycleScrollView!
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var microCourseImage: UIImageView!
    @IBOutlet weak var liveCourseImage: UIImageView!
    @IBOutlet weak var MVImage: UIImageView!
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension findViewController: MYCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: MYCycleScrollView, didScrollTo index: Int) {
        print("didScrollTo: \(index)")
    }
    func cycleScrollView(_ cycleScrollView: MYCycleScrollView, didSelectItemAt index: Int) {
        print("didSelectItemAt: \(index)")
        
        let videoPlayerViewController = videoPlayerViewController()
        self.navigationController?.pushViewController(videoPlayerViewController, animated: true)
    }
}

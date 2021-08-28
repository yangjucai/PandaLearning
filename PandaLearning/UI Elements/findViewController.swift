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
        
        let cycleScrollView = MYCycleScrollView(frame: CGRect(x: 0, y: 140, width: view.bounds.width, height: 300))
        cycleScrollView.imageURLs = [ "https://s3.bmp.ovh/imgs/2021/08/c36e908c93e0fa1e.png",
                                       "https://i.bmp.ovh/imgs/2021/08/03970bbfaf60b395.gif",
                                        "https://s3.bmp.ovh/imgs/2021/08/23403d5a47e77e66.png"]
        cycleScrollView.autoScrollTimeInterval = 5
        cycleScrollView.imageViewContentMode = .scaleAspectFill
        cycleScrollView.delegate = self
        
        self.view.addSubview(cycleScrollView)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    }
}

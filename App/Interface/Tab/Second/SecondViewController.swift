//
//  SecondViewController.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        label.text = "second"
        label.textColor = .black
        view.addSubview(label)
        
        view.backgroundColor = .white
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

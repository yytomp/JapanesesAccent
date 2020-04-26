//
//  ViewController_filter.swift
//  leftRIghtGame
//
//  Created by Matthew Anning on 8/2/20.
//  Copyright © 2020 Matthew Anning. All rights reserved.
//

import UIKit

class ViewController_filter: UIViewController {

    @IBOutlet var filterButtons: [UIButton]!
    
    @IBOutlet var nacTitle: UINavigationItem!
    
    
    @IBOutlet weak var btn_tick: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    var titleName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nacTitle.title = titleName
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_selected(_ sender: UIButton) {
        if (sender.tintColor == UIColor.systemGray){
            sender.tintColor = UIColor.systemBlue
        }else{
            sender.tintColor = UIColor.systemGray
        }
    }
    
    @IBAction func cancel_selected(_ sender: UIButton) {
        filterButtons.forEach{selection in
            selection.tintColor = UIColor.systemGray
        }
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

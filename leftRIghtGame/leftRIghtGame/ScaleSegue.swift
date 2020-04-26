//
//  ScaleSegue.swift
//  leftRIghtGame
//
//  Created by Matthew Anning on 17/4/20.
//  Copyright © 2020 Matthew Anning. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}


extension ScaleSegue : UIViewControllerTransitioningDelegate{
    
}

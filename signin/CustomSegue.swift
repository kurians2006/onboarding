//
//  CustomSegue.swift
//  signin
//
//  Created by Wouter van de Kamp on 23/12/2016.
//  Copyright © 2016 Wouter. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let source = self.source
        let destination = self.destination
        let container = source.parent!
        container.addChildViewController(destination)
        destination.view.frame = CGRect(x: source.view.frame.width, y: 0.0, width: source.view.frame.width, height: source.view.frame.height)
        source.willMove(toParentViewController: nil)

        container.transition(from: source, to: destination, duration: 0.25, options: .curveEaseInOut, animations: {() -> Void in
            destination.view.frame = CGRect(x: 0.0, y: 0.0, width: source.view.frame.width, height: source.view.frame.height)
            source.view.frame = CGRect(x: -source.view.frame.width, y: 0.0, width: source.view.frame.width, height: source.view.frame.height)
        }, completion: {(_ finished: Bool) -> Void in
            source.removeFromParentViewController()
            destination.didMove(toParentViewController: container)
        })
    }
}

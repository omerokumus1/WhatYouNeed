//
//  MapViewController.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 15.04.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if segue.identifier == "goToDetails" {
            let vc = segue.destination
            if vc.presentingViewController?.isBeingPresented ?? false {
                self.present(vc, animated: true)
            } else {
                print("you probably crashed here!")
            }
        }
    }

    

}

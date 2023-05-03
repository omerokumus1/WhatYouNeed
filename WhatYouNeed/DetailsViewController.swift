//
//  DetailsViewController.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 15.04.2023.
//

import UIKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextView!
    @IBOutlet weak var needsTxt: UITextView!
    @IBOutlet weak var addressContainer: UIView!
    @IBOutlet weak var needsContainer: UIView!
    
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        //        dummyInit()
        initNameTxt()
        initPhoneTxt()
        initAddressTxt()
        initNeedsTxt()
        
    }
    
    private func initNameTxt() {
        nameTxt.text = person?.name
        applyShadow(view: nameTxt)
        nameTxt.layer.cornerRadius = 8
        nameTxt.backgroundColor = .clear
    }
    
    private func initPhoneTxt() {
        phoneTxt.text = person?.phone
        applyShadow(view: phoneTxt)
        phoneTxt.layer.cornerRadius = 8
        phoneTxt.backgroundColor = .clear
    }
    
    
    private func dummyInit() {
        nameTxt.text = "John Doe"
        phoneTxt.text = "+90 555 111 22 33"
        addressTxt.text = """
                    8 Jockey Hollow Dr.
                    Georgetown, SC 29440
                    """
        needsTxt.text = """
                        Need 1
                        Need 2
                        Need 3
                        Need 4
                        Need 5
                        Need 6
                        Need 7
                        Need 8
                        """
    }
    
    
    private func initAddressTxt() {
        setAddress()
        addressTxt.font = UIFont.systemFont(ofSize: 20.0)
        addressContainer.layer.cornerRadius = 8
        addressContainer.backgroundColor = .clear
        addressTxt.layer.cornerRadius = 8
        addressTxt.backgroundColor = .clear
        applyShadow(view: addressContainer)
    }
    
    private func setAddress() {
        guard let person = person else {return}
        var address = ""
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(person.location) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            if let _ = error {
                return
            }
            guard let placemark = placemarks?.first else {return}
            let streetNumber = placemark.subThoroughfare
            let streetName = placemark.thoroughfare
            let city = placemark.locality
            address.append(streetName ?? "")
            address.append("\n")
            address.append("No: ")
            address.append(streetNumber ?? "")
            address.append("\n")
            address.append(placemark.subLocality ?? "")
            address.append("/")
            address.append(city ?? "")
            address.append("/")
            address.append(placemark.country ?? "")
            address.append(", ")
            address.append(placemark.postalCode ?? "")
            
            DispatchQueue.main.async {
                self.addressTxt.text = address
            }
        }
        
        
    }
    
    private func initNeedsTxt() {
        needsTxt.text = person?.needs.joined(separator: "\n")
        needsTxt.font = UIFont.systemFont(ofSize: 20.0)
        needsContainer.layer.cornerRadius = 8
        needsContainer.backgroundColor = .none
        needsTxt.layer.cornerRadius = 8
        needsTxt.backgroundColor = .none
        applyShadow(view: needsContainer)
    }
    
    private func applyShadow(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 4.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.gray.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addressTxt.flashScrollIndicators()
        needsTxt.flashScrollIndicators()
    }
    
}

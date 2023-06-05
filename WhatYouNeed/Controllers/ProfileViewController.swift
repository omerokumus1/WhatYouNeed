//
//  ViewController.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 14.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextView!
    @IBOutlet weak var needsTxt: UITextView!
    @IBOutlet weak var addressContainer: UIView!
    @IBOutlet weak var needsContainer: UIView!
    private var currentUser: Person? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        currentUser = CurrentUser.shared.value
        initNameTxt()
        initPhoneTxt()
        initAddressTxt()
        initNeedsTxt()
        initTexts()
        
    }
    
    private func initTexts() {
        nameTxt.text = currentUser?.name
        phoneTxt.text = currentUser?.phone
        addressTxt.text = currentUser?.address
        needsTxt.text = currentUser?.needs
    }
    
    private func initNameTxt() {
        applyShadow(view: nameTxt)
        nameTxt.layer.cornerRadius = 8
        nameTxt.backgroundColor = .clear
    }
    
    private func initPhoneTxt() {
        applyShadow(view: phoneTxt)
        phoneTxt.layer.cornerRadius = 8
        phoneTxt.backgroundColor = .clear
    }
    
    private func initAddressTxt() {
        addressTxt.font = UIFont.systemFont(ofSize: 20.0)
        addressContainer.layer.cornerRadius = 8
        addressContainer.backgroundColor = .clear
        addressTxt.layer.cornerRadius = 8
        addressTxt.backgroundColor = .clear
        applyShadow(view: addressContainer)
    }
    
    private func initNeedsTxt() {
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
    
    @IBAction func onSaveClicked(_ sender: UIButton) {
        let person = Person(id: currentUser?.id, name: nameTxt.text ?? "", phone: phoneTxt.text ?? "",
                            location: CurrentUser.shared.value?.location, address: addressTxt.text ?? "", needs: needsTxt.text)
        CurrentUser.set(to: person)
        
    }
    
}


//
//  TranslateViewController.swift
//  Morsing
//
//  Created by Levy Cristian  on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    public var isTranslateToMorse: Bool = false
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
    
        return scroll
    }()
    
    private lazy var caracters: [Item] = {
        var caracters:[Item] = []
        if let letters = Item.letters(), let numbers = Item.numbers(){
            caracters.append(contentsOf: letters)
            caracters.append(contentsOf: numbers)
        }
        return caracters
    }()
    fileprivate lazy var translateView: TranslateView = {
        let view = TranslateView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgoundGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    
    fileprivate func setUp(){
        tabBarSetup()
        addViews()
        setUPConstraints()
        translateView.setUP()
        _ = isTranslateToMorse ? (navigationBarSetup(name: "Morse"), translateView.setUPMorse()) :  (navigationBarSetup(name: "Text"), translateView.setUPText())
        
        translateView.tap.addTarget(self, action: #selector(chageArrow))
        translateView.inputTextView.delegate = self
    }
     
    fileprivate func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(translateView)
        
    }
    
    fileprivate func setUPConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        translateView.translatesAutoresizingMaskIntoConstraints = false
        translateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        translateView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        translateView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        translateView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1, constant: 0).isActive = true
        

    }

    fileprivate func navigationBarSetup(name: String) {
        
        navigationItem.title = name
        navigationController?.navigationBar.tintColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        
    }
    fileprivate func tabBarSetup(){
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isOpaque = false
        
    }
    @objc private func chageArrow(){
        if isTranslateToMorse {
            isTranslateToMorse = false
            navigationItem.title = "Text"
            translateView.setUPText()
        }else{
            isTranslateToMorse = true
            navigationItem.title = "Morse"
            translateView.setUPMorse()
        }
    }

}
extension TranslateViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type something..."
            textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5)
            translateView.responseTextView.text = "Response goes here"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5) {
            textView.text = nil
            textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {

        if isTranslateToMorse{
            
        }else{
            if let text = textView.text {
                translateView.responseTextView.text = ""
                for  letters in text{
                    if (letters == " "){
                        translateView.responseTextView.text += "/"
                    }else{
                        let item = caracters.filter {$0.text == String(letters).capitalized}
                        if (item.count < 1){
                            textView.text = textView.text.replacingOccurrences(of: "\(letters)", with: "", options: .literal, range: nil)
                            self.showAlert(title:"Worng Format", menssage: " \" \(letters) \" is an invalid Character")
                            
                        }else{
                            let morse = item[0].morse
                            for (index, _) in morse.enumerated(){
                                if (morse[index] == 1) {
                                    translateView.responseTextView.text += "-"
                                }else{
                                    translateView.responseTextView.text += "."
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

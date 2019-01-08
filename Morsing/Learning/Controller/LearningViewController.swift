//
//  LearningViewController.swift
//  Morsing
//
//  Created by Paloma Bispo on 07/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupLayout()


        // Do any additional setup after loading the view.
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        setupLayout()
//    }
    
    
    @objc func tapNumbers(_ sender: UITapGestureRecognizer){
        let charactersVC = CharactersViewController()
        charactersVC.isLetters = false
        navigationController?.pushViewController(charactersVC, animated: true)
    }
    @objc func tapLetters(_ sender: UITapGestureRecognizer){
        let charactersVC = CharactersViewController()
        charactersVC.isLetters = true
        navigationController?.pushViewController(charactersVC, animated: true)
    }
    
    // MARK: - Setups
    
    func setupLayout(){
        let viewLetters = UIView()
        let viewNumbers = UIView()
        let viewBlurNumbers = UIView()
        let viewBlurLetters = UIView()
        
        let gestureLetters = UITapGestureRecognizer(target: self, action: #selector(tapLetters(_:)))
        let gestureNumbers = UITapGestureRecognizer(target: self, action: #selector(tapNumbers(_:)))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectViewLetter = UIVisualEffectView(effect: blurEffect)
        let blurEffectViewNumbers = UIVisualEffectView(effect: blurEffect)
        
        let numbersLabel1 = UILabel()
        let numbersLabel2 = UILabel()
        let lettersLabel1 = UILabel()
        let lettersLabel2 = UILabel()
        
        let layerLetters = CAShapeLayer()
        let layerNumbers = CAShapeLayer()
        let pathLetters = UIBezierPath()
        let pathNumbers = UIBezierPath()
        
        viewNumbers.addGestureRecognizer(gestureNumbers)
        viewLetters.addGestureRecognizer(gestureLetters)
        
        pathLetters.move(to: CGPoint(x: 0, y: 0))
        pathLetters.addLine(to: CGPoint(x: 0, y: view.frame.height))
        pathLetters.addLine(to: CGPoint(x: view.frame.width, y: 0))
        pathLetters.close()
        
        pathNumbers.move(to: CGPoint(x: view.frame.width, y: view.frame.height))
        pathNumbers.addLine(to: CGPoint(x: view.frame.width, y: 0))
        pathNumbers.addLine(to: CGPoint(x: 0, y: view.frame.height))
        pathNumbers.close()
        
        layerLetters.path = pathLetters.cgPath
        layerNumbers.path = pathNumbers.cgPath
        layerLetters.fillColor = UIColor(red: 29/255, green: 229/255, blue: 226/255, alpha: 1.0).cgColor
        layerNumbers.fillColor = UIColor(red: 181/255, green: 136/255, blue: 247/255, alpha: 1.0).cgColor
        viewLetters.layer.addSublayer(layerLetters)
        viewNumbers.layer.addSublayer(layerNumbers)
        viewLetters.frame = viewLetters.layer.frame
        viewNumbers.frame = viewNumbers.layer.frame
        
        numbersLabel1.text = "1"
        numbersLabel2.text = "Numbers"
        lettersLabel1.text = "L"
        lettersLabel2.text = "Letters"
        numbersLabel1.sizeToFit()
        numbersLabel2.sizeToFit()
        lettersLabel1.sizeToFit()
        lettersLabel2.sizeToFit()
        numbersLabel1.textColor = UIColor.black
        numbersLabel2.textColor = UIColor.black
        lettersLabel1.textColor = UIColor.black
        lettersLabel2.textColor = UIColor.black
        
        //appling blur
        blurEffectViewLetter.frame = viewBlurLetters.bounds
        blurEffectViewNumbers.frame = viewBlurNumbers.bounds
        blurEffectViewNumbers.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectViewLetter.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        viewBlurNumbers.backgroundColor = UIColor.red
//        viewBlurLetters.backgroundColor = UIColor.red
        viewBlurLetters.addSubview(blurEffectViewLetter)
        viewBlurNumbers.addSubview(blurEffectViewNumbers)
        
        viewBlurLetters.addSubview(lettersLabel2)
        viewBlurNumbers.addSubview(numbersLabel2)
        
        viewNumbers.addSubview(numbersLabel1)
        viewNumbers.addSubview(numbersLabel2)
        viewNumbers.addSubview(viewBlurNumbers)
        viewLetters.addSubview(lettersLabel1)
        viewLetters.addSubview(lettersLabel2)
        viewLetters.addSubview(viewBlurLetters)
        
        self.view.addSubview(viewLetters)
        self.view.addSubview(viewNumbers)
        
        //**contraints**
//        lettersLabel1.translatesAutoresizingMaskIntoConstraints = false
        lettersLabel2.translatesAutoresizingMaskIntoConstraints = false
//        numbersLabel1.translatesAutoresizingMaskIntoConstraints = false
//        numbersLabel2.translatesAutoresizingMaskIntoConstraints = false
        viewBlurLetters.translatesAutoresizingMaskIntoConstraints = false
//        viewBlurNumbers.translatesAutoresizingMaskIntoConstraints = false
        viewLetters.translatesAutoresizingMaskIntoConstraints = false
        
        //viewLetters
        viewLetters.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewLetters.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewLetters.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewLetters.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        //contraints letterslabel2
        lettersLabel2.centerYAnchor.constraint(equalTo: viewBlurLetters.centerYAnchor).isActive = true
        lettersLabel2.centerXAnchor.constraint(equalTo: viewBlurLetters.centerXAnchor).isActive = true
        
        // contraints viewBlurLetters
        viewBlurLetters.trailingAnchor.constraint(equalTo: viewLetters.trailingAnchor, constant: 16).isActive = true
        viewBlurLetters.leadingAnchor.constraint(equalTo: viewLetters.leadingAnchor, constant: 16).isActive = true
        viewBlurLetters.centerYAnchor.constraint(equalToSystemSpacingBelow: viewLetters.centerYAnchor, multiplier: 2).isActive = true
    
        viewBlurLetters.heightAnchor.constraint(equalTo: viewLetters.heightAnchor, multiplier: 0.15).isActive = true
        
        
       
        

        //lettersLabel2.trailingAnchor.con
        
//        newView.translatesAutoresizingMaskIntoConstraints = false
//        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        newView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
//        viewNumbers.backgroundColor = UIColor(red: 181/255, green: 136/255, blue: 247/255, alpha: 1.0)
//        viewLetters.backgroundColor =  UIColor(red: 29/255, green: 229/255, blue: 226/255, alpha: 1.0)
        
       
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

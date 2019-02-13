//
//  TranslateView.swift
//  Morsing
//
//  Created by Levy Cristian  on 11/01/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateView: UIView {
    
    fileprivate lazy var fristView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    fileprivate lazy var responseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    fileprivate lazy var fristLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.numberOfLines = 1
        label.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    fileprivate lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Morse"
        label.numberOfLines = 1
        label.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    fileprivate lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "singleArrow")
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    fileprivate lazy var stackBackgorudView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    fileprivate lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.addArrangedSubview(fristLabel)
        stack.addArrangedSubview(arrowImage)
        stack.addArrangedSubview(secondLabel)
        
        return stack
    }()
    
    public lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Type something..."
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5)
        return textView
    }()
    
    fileprivate lazy var translateLabel: UILabel = {
        let label = UILabel()
        label.text = "translateLabel"
        label.numberOfLines = 1
        label.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var responseTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Response goes here..."
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.textColor = UIColor(red:0.20, green:0.30, blue:0.36, alpha:0.5)
        textView.isEditable = false
        return textView
    }()
    
    fileprivate lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        stack.addArrangedSubview(copyButton)
        stack.addArrangedSubview(sharedButton)
        
        return stack
    }()
    
    public lazy var hearButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "sound"), for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var copyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "copy"), for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var sharedButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setImage(UIImage(named: "shared"), for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitleColor(UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0), for: UIControl.State.highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fristView.layoutSubviews()
        buttonsStackView.layoutSubviews()
        setGradientsToButtons()
        configureShadow()
    }
    
    public func setUP(){
        addViews()
        setUpConstraints()
        arrowImage.addGestureRecognizer(tap)
    }
    
    public func setUPText(){
        
        if (hearButton.superview == nil){
            buttonsStackView.addArrangedSubview(hearButton)
        }
        buttonsStackView.layoutSubviews()
        setGradientsToButtons()
        translateLabel.text = "Morse"
        responseTextView.text = "Response goes here..."
        inputTextView.text = nil
        animateRowToRight()
    }
    
    public func setUPMorse(){
        if  (hearButton.superview != nil) {
            hearButton.removeFromSuperview()
        }
        buttonsStackView.layoutSubviews()
        setGradientsToButtons()
        translateLabel.text = "Text"
        responseTextView.text = "Response goes here..."
        inputTextView.text = nil
        animateRowToleft()
    }
    
    fileprivate func addViews(){
        self.addSubview(fristView)
        fristView.addSubview(stackBackgorudView)
        stackBackgorudView.addSubview(labelsStackView)
        fristView.addSubview(inputTextView)
        
        self.addSubview(responseView)
        responseView.addSubview(translateLabel)
        responseView.addSubview(responseTextView)
        responseView.addSubview(buttonsStackView)
        
    }
    
    
    fileprivate func setUpConstraints(){
        fristView.translatesAutoresizingMaskIntoConstraints = false
        fristView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        fristView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        fristView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        fristView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        stackBackgorudView.anchor(top: fristView.safeAreaLayoutGuide.topAnchor,
                                  leading: fristView.safeAreaLayoutGuide.leadingAnchor,
                                  bottom: nil, trailing: fristView.safeAreaLayoutGuide.trailingAnchor,
                                  padding:  UIEdgeInsets(top: 8, left: 1.2, bottom: 0, right: 1.2),
                                  size: .zero)
       stackBackgorudView.heightAnchor.constraint(equalTo: fristView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        
        labelsStackView.anchor(top: stackBackgorudView.safeAreaLayoutGuide.topAnchor,
                         leading: stackBackgorudView.safeAreaLayoutGuide.leadingAnchor,
                         bottom: nil,
                         trailing: stackBackgorudView.safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 40, bottom: 0, right: 40),
                         size: .zero)
        
        inputTextView.anchor(top: stackBackgorudView.safeAreaLayoutGuide.bottomAnchor,
                             leading: fristView.safeAreaLayoutGuide.leadingAnchor,
                             bottom: fristView.safeAreaLayoutGuide.bottomAnchor,
                             trailing: fristView.safeAreaLayoutGuide.trailingAnchor,
                             padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0),
                             size: .zero)
        
        
        
        responseView.translatesAutoresizingMaskIntoConstraints = false
        responseView.topAnchor.constraint(equalTo: fristView.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        responseView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        responseView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        responseView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        translateLabel.anchor(top: responseView.safeAreaLayoutGuide.topAnchor,
                              leading: responseView.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: responseView.safeAreaLayoutGuide.trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 12, bottom: 0, right: 0),
                              size: .zero)
        
        responseTextView.anchor(top: translateLabel.safeAreaLayoutGuide.bottomAnchor,
                             leading: responseView.safeAreaLayoutGuide.leadingAnchor,
                             bottom: nil,
                             trailing: responseView.safeAreaLayoutGuide.trailingAnchor,
                             padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8),
                             size: .zero)
        responseTextView.heightAnchor.constraint(equalTo: responseView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        
        buttonsStackView.anchor(top: responseTextView.safeAreaLayoutGuide.bottomAnchor,
                                leading: nil,
                                bottom: responseView.safeAreaLayoutGuide.bottomAnchor,
                                trailing: responseTextView.safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets.zero,
                                size: .zero)
        buttonsStackView.widthAnchor.constraint(equalTo: responseView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4).isActive = true

    }
    
    private func configureShadow() {
        
        self.applyShadow(view: self.fristView,width: CGFloat(0), height: CGFloat(0))
        self.applyShadow(view: self.responseView,width: CGFloat(0), height: CGFloat(0))
        self.applyShadow(view: self.stackBackgorudView, width: CGFloat(0), height: CGFloat(7), opacity: 0.15, radius: 5.0)
        
    }
    private func applyShadow(view: UIView, width: CGFloat, height: CGFloat, opacity: Float = 0.3, radius: CGFloat = 3.0) {
        
        let shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = radius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowOpacity = opacity
        view.layer.shadowPath = shadowPath.cgPath
        
    }
    
    fileprivate func animateRowToRight(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            
            self.arrowImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }, completion:{ _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                
            }, completion: nil)
        })
    }
    
    fileprivate func animateRowToleft(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
          
            self.arrowImage.transform = CGAffineTransform(scaleX: -1, y: 1)
            
        }, completion:{ _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                
            }, completion: nil)
        })
    }
    
    fileprivate func setGradientsToButtons(){
        if let leyers1 = hearButton.layer.sublayers, let leyers2 = copyButton.layer.sublayers, let leyers3 = sharedButton.layer.sublayers{
            
            for layer in leyers1 {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
            for layer in leyers2 {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
            for layer in leyers3 {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        
        }
        hearButton.setGradientToView(opition: .Default)
        copyButton.setGradientToView(opition: .Default)
        sharedButton.setGradientToView(opition: .Default)

    }

}

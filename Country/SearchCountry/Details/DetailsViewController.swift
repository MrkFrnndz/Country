//
//  DetailsViewController.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/29/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import WebKit
import SwiftSVG
import MaterialComponents.MDCCard

protocol DetailsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailsViewController: UIViewController, DetailsPresentable, DetailsViewControllable {

    weak var listener: DetailsPresentableListener?

    var btnBack = MDCCard()
    var lblBack = UILabel()
    var imgBack = UIImageView()
    var imgFlag = WKWebView()
    var lblPopulation = UILabel()
    var lblCountryName = UILabel()
    var lblCapital = UILabel()
    var lblCode = UILabel()
    
    var activityIndicator = UIActivityIndicatorView().apply {
        $0.style = .gray
    }
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        btnBack = MDCCard().apply {
            $0.cornerRadius = 20
            $0.backgroundColor = .white
            $0.addTo(view)
        }
        
        imgBack = UIImageView().apply {
            $0.image = UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .black
            $0.addTo(view)
        }
        
        lblBack = UILabel().apply {
            $0.text = "Back"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont.appBoldFontWith(ofSize: 20)
            $0.addTo(view)
        }
        
        imgFlag = WKWebView().apply {
            $0.navigationDelegate = self
            if #available(iOS 13.0, *) {
                $0.scalesLargeContentImage = false
            } else {
                // Fallback on earlier versions
            }
            $0.contentScaleFactor = 50
            $0.layer.masksToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTo(view)
        }
        
        lblCountryName = UILabel().apply {
            $0.text = "Country Name"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont.appBoldFontWith(ofSize: 20)
            $0.addTo(view)
        }
        
        lblCapital = UILabel().apply {
            $0.text = "Capital"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6954730308)
            $0.font = UIFont.appRegularFontWith(ofSize: 20)
            $0.addTo(view)
        }
        
        lblCode = UILabel().apply {
            $0.text = "code"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6954730308)
            $0.font = UIFont.appRegularFontWith(ofSize: 20)
            $0.addTo(view)
        }
        
        lblPopulation = UILabel().apply {
            $0.text = "Population"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6954730308)
            $0.font = UIFont.appRegularFontWith(ofSize: 20)
            $0.addTo(view)
        }
        
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
        

        btnBack.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            } else {
                $0.top.equalToSuperview().offset(16)
            }
            $0.left.equalToSuperview().offset(16)
            $0.height.width.equalTo(40)
        }
        
        imgBack.snp.makeConstraints {
            $0.centerX.centerY.equalTo(btnBack)
        }
        
        lblBack.snp.makeConstraints {
            $0.left.equalTo(btnBack.snp.right).offset(10)
            $0.centerY.equalTo(btnBack)
        }
        
        imgFlag.snp.makeConstraints {
            $0.top.equalTo(btnBack.snp.bottom).offset(32)
            $0.width.equalTo(350)
            $0.height.equalTo(210)
            $0.left.equalToSuperview().offset(16)
        }
        
        lblCountryName.snp.makeConstraints {
            $0.top.equalTo(imgFlag.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
        }
        
        lblCapital.snp.makeConstraints {
            $0.top.equalTo(lblCountryName.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
        }
        
        lblCode.snp.makeConstraints {
            $0.top.equalTo(lblCapital.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
        }
        
        lblPopulation.snp.makeConstraints {
            $0.top.equalTo(lblCode.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(imgFlag)
            activityIndicator.startAnimating()
        }
        
        btnBack.rx
            .controlEvent(.touchDown)
            .asObservable().subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
        .disposed(by: disposeBag)
        
    }
    
    func setData(country: Country) {
        lblCountryName.text = country.name
        lblCapital.text = country.capital
        lblCode.text = country.alpha2Code
        lblPopulation.text =  "\(country.population)"
        
        //FLAG
        let url = URL(string: country.flag)
        let request = URLRequest(url: url!)
        let svgString = try? String(contentsOf: url!)
        imgFlag.loadHTMLString(svgString!, baseURL: URL(string: country.flag))
        
    }
}

extension DetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         self.activityIndicator.removeFromSuperview()
    }
}

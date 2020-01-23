//
//  SearchCountryViewController.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/23/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import MaterialComponents.MDCCard

protocol SearchCountryPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchCountryViewController: UIViewController, SearchCountryPresentable, SearchCountryViewControllable {

    weak var listener: SearchCountryPresentableListener?
    
    private var cardSearch = MDCCard()
    private var txtSearch = UITextField()
    
    private var tableView: UITableView!
    private let cellReuseIdentifier = "CountryCell"
    
    private let disposeBag = DisposeBag()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.934525698, green: 0.934525698, blue: 0.934525698, alpha: 1)
        
        cardSearch = MDCCard().apply {
            $0.setShadowColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.cornerRadius = 4
            $0.addTo(view)
        }
        
        txtSearch = UITextField().apply {
//            $0.font = UIFont.appRegularFontWith(ofSize: 16)
            let hasValue = txtSearch.text != ""
            $0.placeholder = "Search Organization"
            $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            $0.borderStyle = UITextField.BorderStyle.none
            $0.autocorrectionType = UITextAutocorrectionType.no
            $0.keyboardType = UIKeyboardType.default
            $0.returnKeyType = UIReturnKeyType.next
            $0.clearButtonMode = UITextField.ViewMode.whileEditing;
            $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            
            $0.isUserInteractionEnabled = true
            $0.addTo(cardSearch)
            $0.sizeToFit()
        }
        
        tableView = UITableView().apply {
            $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addTo(view)
            $0.delegate = self
            $0.dataSource = self
            $0.register(CountryCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
            $0.showsHorizontalScrollIndicator = false
        }
        
        cardSearch.snp.makeConstraints() {
            if #available(iOS 11.0, *) {
                $0.top.left.right.equalTo(view.safeAreaLayoutGuide).offset(16)
            } else {
                $0.top.equalToSuperview().offset(16)
            }
            $0.left.right.equalToSuperview().offset(16).inset(16)
            $0.height.equalTo(40)
        }
        
        txtSearch.snp.makeConstraints() {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
    }
}

class CountryCell: UITableViewCell {
    
//    var place: Place!
    let disposeBag = DisposeBag()
    
    let card = MDCCard().apply {
        $0.setShadowElevation(ShadowElevation(rawValue: 0), for: .normal)
        $0.setShadowColor(.clear, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.cornerRadius = 0
    }
    
    let line = UIView().apply {
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08)
    }
    
    let container = UIView().apply {
        $0.backgroundColor = .clear
    }
    
    let imgCircle = UIImageView().apply {
        $0.image = UIImage(named: "ic_circle")
    }
    
    let lblDistance = UILabel().apply {
        $0.text = ""
        $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.font = UIFont.appRegularFontWith(ofSize: 10)
    }
    
    let lblPlace = UILabel().apply {
        $0.text = ""
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.appRegularFontWith(ofSize: 14)
    }
    
    let lblDescription = UILabel().apply {
        $0.text = "Paranaque Integrated Terminal Exchange"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6954730308)
        $0.font = UIFont.appRegularFontWith(ofSize: 10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(card)
        sendSubviewToBack(card)
        addSubview(container)
        addSubview(imgCircle)
        addSubview(lblDistance)
        addSubview(lblPlace)
        addSubview(lblDescription)
    
        
        card.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalTo(60)
        }
        
        container.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(30)
            maker.height.equalTo(40)
            maker.centerY.equalToSuperview()
        }
        
        imgCircle.snp.makeConstraints { (maker) in
            maker.left.equalTo(container.snp.left)
            maker.top.equalTo(container.snp.top)
            maker.size.equalTo(20)
        }
        
        lblDistance.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(container.snp.bottom)
            maker.centerX.equalTo(imgCircle.snp.centerX)
        }
        
        lblPlace.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgCircle.snp.right).offset(20)
            maker.top.equalTo(imgCircle.snp.top)
            maker.right.equalToSuperview().offset(-16)
        }
        
        lblDescription.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgCircle.snp.right).offset(20)
            maker.right.equalToSuperview().offset(-16)
            maker.bottom.equalTo(lblDistance.snp.bottom)
        }

//        card.rx.tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { [weak self] _ in
//                self?.clickPlaceRelay.accept(self!.place!)
//            })
//            .disposed(by: disposeBag)
    }
    
//    func setData(place: Place, userCoord: CLLocationCoordinate2D) {
//        self.place = place
//        
//        lblPlace.text = place.label.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
//        lblDescription.text = place.description.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
//        lblDistance.text = "\(String(format: "%.2f", (place.distanceInMeters ?? 0) / 1000)) km"
//    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
 

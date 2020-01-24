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
    
    private var countries: [Country] = []
    
    
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
        
        cardSearch.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.left.right.equalTo(view.safeAreaLayoutGuide).offset(16)
            } else {
                $0.top.equalToSuperview().offset(16)
            }
            $0.left.right.equalToSuperview().offset(16).inset(16)
            $0.height.equalTo(40)
        }
        
        txtSearch.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(cardSearch.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setData(countries: [Country]) {
        self.countries.append(contentsOf: countries)
        tableView.reloadData()
        
        print("COUNTRYIES : \(self.countries)")
    }
}

class CountryCell: UITableViewCell {
    
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
    
    let imgFlag = UIImageView().apply {
//        $0.image = UIImage(named: "ic_default")
        $0.contentMode = .center
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let lblPopulation = UILabel().apply {
        $0.text = "0"
        $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.font = UIFont.appRegularFontWith(ofSize: 10)
    }
    
    let lblCountryName = UILabel().apply {
        $0.text = "Country Name"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.appRegularFontWith(ofSize: 14)
    }
    
    let lblCapital = UILabel().apply {
        $0.text = "Capital"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6954730308)
        $0.font = UIFont.appRegularFontWith(ofSize: 10)
    }
    
    let lblCode = UILabel().apply {
        $0.text = "code"
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
        addSubview(imgFlag)
        addSubview(lblPopulation)
        addSubview(lblCountryName)
        addSubview(lblCapital)
        addSubview(lblCode)
    
        
        card.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalTo(80)
        }
        
        container.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(30)
            maker.height.equalTo(60)
            maker.centerY.equalToSuperview()
        }
        
        imgFlag.snp.makeConstraints { (maker) in
            maker.left.equalTo(container.snp.left)
            maker.top.equalTo(container.snp.top)
            maker.size.equalTo(15)
        }
        
        lblPopulation.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(container.snp.bottom)
            maker.centerX.equalTo(imgFlag.snp.centerX)
        }
        
        lblCountryName.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgFlag.snp.right).offset(20)
            maker.top.equalTo(imgFlag.snp.top)
            maker.right.equalToSuperview().offset(-16)
        }
        
        lblCapital.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgFlag.snp.right).offset(20)
            maker.right.equalToSuperview().offset(-16)
            maker.bottom.equalTo(lblPopulation.snp.bottom)
        }
        
        lblCode.snp.makeConstraints {
            $0.top.equalTo(lblCapital.snp.bottom)
            $0.centerY.equalTo(lblCapital)
        }

//        card.rx.tapGesture()
//            .when(.recognized)
//            .subscribe(onNext: { [weak self] _ in
//                self?.clickPlaceRelay.accept(self!.place!)
//            })
//            .disposed(by: disposeBag)
    }
    
    func setData(country: Country) {
        
        lblCountryName.text = country.name.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        lblCapital.text = country.capital.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        lblCode.text = country.alpha2Code
        lblPopulation.text = "\(String(format: "%.d", country.population))"
    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CountryCell
        cell.setData(country: self.countries[indexPath.row])
        
        cell.imgFlag.contentMode = .scaleAspectFill
        cell.imgFlag.imageFromURL(urlString: self.countries[indexPath.row].flag ?? "")
        
        return cell
    }


}


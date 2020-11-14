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
import SDWebImageSVGKitPlugin

protocol SearchCountryPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func searchCountry(_ q: String)
    func fetchCountry()
    func goToDetails(country: Country)
}

final class SearchCountryViewController: UIViewController, SearchCountryPresentable, SearchCountryViewControllable {

    weak var listener: SearchCountryPresentableListener?
    
    private var cardSearch = MDCCard()
    private var txtSearch = UITextField()
    private var noContentlbl = UILabel()
    
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
        view.backgroundColor = #colorLiteral(red: 0.9059327411, green: 0.9059327411, blue: 0.9059327411, alpha: 1)
        
        cardSearch = MDCCard().apply {
            $0.setShadowColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.cornerRadius = 4
            $0.addTo(view)
        }
        
        txtSearch = UITextField().apply {
            $0.font = UIFont.appRegularFontWith(ofSize: 16)
            let hasValue = txtSearch.text != ""
            $0.placeholder = "Search Country"
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
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(CountryCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
            $0.showsHorizontalScrollIndicator = false
            $0.addTo(view)
        }
        
        noContentlbl = UILabel().apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Country not found."
            $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.font = UIFont.appBoldFontWith(ofSize: 20)
            $0.isHidden = true
            $0.addTo(view)
            
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
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
        
        txtSearch.rx.controlEvent([.editingChanged])
//            .filter{ self.txtSearch.text != nil && self.txtSearch.text != "" }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .asObservable()
            .subscribe(onNext: { [weak self] ( _) in
                guard let this = self else { return }
                if self?.txtSearch.text != nil && self?.txtSearch.text != "" {
                    self?.listener?.searchCountry(self!.txtSearch.text!)
                } else {
                    self?.listener?.fetchCountry()
                }
                
            }).disposed(by: disposeBag)
    }
    
    func setData(countries: [Country]) {
        self.countries.removeAll()
        self.countries.append(contentsOf: countries)
        tableView.reloadData()
        
        print("COUNTRYIES : \(self.countries)")
        
        if countries.count == 0 {
            tableView.isHidden = true
            noContentlbl.isHidden = false
        } else {
            tableView.isHidden = false
            noContentlbl.isHidden = true
        }
    }
    
    func present(viewController: ViewControllable) {
        let vc = viewController.uiviewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }
}

class CountryCell: UITableViewCell {
    
    let card = MDCCard().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setShadowElevation(ShadowElevation(rawValue: 0), for: .normal)
        $0.setShadowColor(.clear, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.cornerRadius = 0
    }
    
    let line = UIView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08)
    }
    
    let container = UIView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    let imgView = UIImageView().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.9250872462, green: 0.9250872462, blue: 0.9250872462, alpha: 1)
        $0.contentMode = .scaleAspectFill
    }
    
    let lblCountryName = UILabel().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Country Name"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont.appBoldFontWith(ofSize: 16)
    }
    
    let lblCapital = UILabel().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Capital"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.font = UIFont.appRegularFontWith(ofSize: 16)
    }
    
    let lblCode = UILabel().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "code"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.font = UIFont.appRegularFontWith(ofSize: 16)
    }
    
    let lblPopulation = UILabel().apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "0"
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.font = UIFont.appRegularFontWith(ofSize: 16)
    }
    
    let activityIndicator = UIActivityIndicatorView().apply {
        $0.style = .gray
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
        addSubview(imgView)
        addSubview(lblPopulation)
        addSubview(lblCountryName)
        addSubview(lblCapital)
        addSubview(lblCode)
        addSubview(activityIndicator)
        bringSubviewToFront(activityIndicator)
    
        
        card.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalTo(100)
        }
        
        container.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(16)
            maker.height.equalTo(80)
            maker.centerY.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (maker) in
            maker.left.equalTo(container.snp.left)
            maker.top.equalTo(container.snp.top)
            maker.bottom.equalTo(container.snp.bottom)
            maker.size.equalTo(100)
        }
        
        lblCountryName.snp.makeConstraints { (maker) in
            maker.left.equalTo(imgView.snp.right).offset(20)
            maker.top.equalTo(imgView.snp.top)
            maker.right.equalToSuperview().offset(-16)
        }
        
        lblCapital.snp.makeConstraints {
            $0.top.equalTo(lblCountryName.snp.bottom)
            $0.left.equalTo(lblCountryName)
        }
        
        lblCode.snp.makeConstraints {
            $0.top.equalTo(lblCapital.snp.bottom)
            $0.left.equalTo(lblCapital)
        }
        
        lblPopulation.snp.makeConstraints {
            $0.top.equalTo(lblCode.snp.bottom)
            $0.left.equalTo(lblCode)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.left.equalTo(container.snp.left)
            $0.top.equalTo(container.snp.top)
            $0.bottom.equalTo(container.snp.bottom)
            $0.width.equalTo(100)
            activityIndicator.startAnimating()
        }
    }
    
    func setData(country: Country) {
        
        lblCountryName.text = country.name.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        lblCapital.text = country.capital.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        lblCode.text = country.alpha2Code
        lblPopulation.text = "\(String(format: "%.d", country.population))"
        
        
        //Loading indicator
        activityIndicator.snp.updateConstraints {
            $0.left.equalTo(container.snp.left)
            $0.top.equalTo(container.snp.top)
            $0.bottom.equalTo(container.snp.bottom)
            $0.width.equalTo(100)
            activityIndicator.startAnimating()
        }

        
        if let url = URL(string: country.flag) {
            let svgCoder = SDImageSVGKCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            imgView.sd_setImage(with: url)
            
            imgView.snp.removeConstraints()
            imgView.snp.makeConstraints { (maker) in
                maker.left.equalTo(container.snp.left)
                maker.top.equalTo(container.snp.top)
                maker.bottom.equalTo(container.snp.bottom)
                maker.size.equalTo(100)
            }
            activityIndicator.stopAnimating()
        }
    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CountryCell
        cell.setData(country: self.countries[indexPath.row])
        
        cell.card.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listener?.goToDetails(country: self.countries[indexPath.row])
        print(self.countries[indexPath.row])
    }


}


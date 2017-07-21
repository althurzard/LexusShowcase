//
//  ViewController.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import DLRadioButton
import Spring
class ViewController: FormViewController {

    struct Constants {
        static let sectionTag = "Section"
        static let overviewRow = "TỔNG QUAN"
        static let colorPicker = "CHỌN MÀU XE"
        static let designRow = "THIẾT KẾ"
        static let operationRow = "VẬN HÀNH"
        static let safetyRow = "AN TOÀN"
        static let libraryRow = "THƯ VIỆN"
        static let specificationRow = "THÔNG SỐ"
    }
    
    fileprivate lazy var heightRow:CGFloat = UIScreen.main.bounds.height - CustomHeader.height
    
    fileprivate lazy var customColorPickerRow: CustomColorPickerRow = self.form.rowBy(tag: Constants.colorPicker) as! CustomColorPickerRow
    
    fileprivate lazy var customOverviewRow: CustomOverviewRow = self.form.rowBy(tag: Constants.overviewRow) as! CustomOverviewRow
    
    fileprivate lazy var customBodyRow: CustomBodyRow = self.form.rowBy(tag: Constants.designRow) as! CustomBodyRow
    
    fileprivate lazy var customOperationRow: CustomOperationRow = self.form.rowBy(tag: Constants.operationRow) as! CustomOperationRow
    
    fileprivate lazy var customSpecificationRow: CustomSpecificationRow = self.form.rowBy(tag: Constants.specificationRow) as! CustomSpecificationRow
    
    fileprivate lazy var customSafetyRow: CustomSafetyRow = self.form.rowBy(tag: Constants.safetyRow) as! CustomSafetyRow
    
    fileprivate lazy var customLirabryRow: CustomLibraryRow = self.form.rowBy(tag: Constants.libraryRow) as! CustomLibraryRow
    
    fileprivate var headerView: CustomHeader?
    
    @IBOutlet weak var radioGroupStackview: UIStackView!
    
    @IBOutlet weak var countdownView: SpringView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var goToTopView: UIView!
    
    var isTopPosition = true
    var timer: Timer = Timer()
    
    var secondsPassed = 0
    var timeCountdown = 10
    fileprivate var currentContentOffset: CGPoint = .zero
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadForm()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customOverviewRow.cell.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let locationOnScreenY = scrollView.contentOffset.y
        
        if locationOnScreenY > currentContentOffset.y {
            if locationOnScreenY <= self.heightRow {
                
                goToRowBy(category: .TongQuan)
                
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                
                goToRowBy(category: .ThietKe)
                
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                
                goToRowBy(category: .VanHanh)
                
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                
                goToRowBy(category: .AnToan)
                
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                if self.customSpecificationRow.cell.height!() > self.heightRow {
                    goToRowBy(category: .ThongSo, position: .bottom)
                } else {
                    goToRowBy(category: .ThongSo)
                }
                
            } else if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(category: .ThuVien)
            }

        } else {
            if locationOnScreenY <= self.heightRow {
                scrollToTop()
                
            } else if locationOnScreenY > self.heightRow, locationOnScreenY <= self.heightRow*2 {
                goToRowBy(category: .TongQuan)
            } else if locationOnScreenY > self.heightRow * 2, locationOnScreenY <= self.heightRow * 3 {
                goToRowBy(category: .ThietKe)
            } else if locationOnScreenY > self.heightRow * 3, locationOnScreenY <= self.heightRow * 4 {
                goToRowBy(category: .VanHanh)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 5 {
                goToRowBy(category: .AnToan)
            } else if locationOnScreenY > self.heightRow * 4, locationOnScreenY <= self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(category: .ThongSo)
            } else if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
                goToRowBy(category: .ThongSo)
            }
        }

        self.currentContentOffset.y = locationOnScreenY
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let locationOnScreenY = scrollView.contentOffset.y
        self.currentContentOffset.y = locationOnScreenY
        startTimer()
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationOnScreenY = scrollView.contentOffset.y

        self.stopScrolling()
        stopTimer()
        if locationOnScreenY < customOverviewRow.cell.height!() / 2 {
            stopScrolling()
            customOverviewRow.cell.startAnimation()
        } else {
            customOverviewRow.cell.prepareAnimation()
        }
            
        if locationOnScreenY < self.heightRow * 1.5, locationOnScreenY > self.heightRow / 2 {
            stopScrolling()
            customColorPickerRow.cell.startAnimation()
        } else {
            customColorPickerRow.cell.prepareAnimation()
        }
            
        if locationOnScreenY < self.heightRow * 2.5, locationOnScreenY > self.heightRow * 1.5 {
            stopScrolling()
            customBodyRow.cell.startAnimation()
        } else {
            customBodyRow.cell.prepareAnimation()
        }
        
        if locationOnScreenY < self.heightRow * 3.5, locationOnScreenY > self.heightRow * 2.5 {
            stopScrolling()
            customOperationRow.cell.startAnimation()
        } else {
            customOperationRow.cell.prepareAnimation()
        }
        
        if locationOnScreenY < self.heightRow * 4.5, locationOnScreenY > self.heightRow * 3.5 {
            stopScrolling()
            customSafetyRow.cell.startAnimation()
        } else {
            customSafetyRow.cell.prepareAnimation()
        }
        
        if locationOnScreenY > self.heightRow * 4 + self.customSpecificationRow.cell.height!() {
            
            customLirabryRow.cell.startAnimation()
        } else {
            customLirabryRow.cell.prepareAnimation()
        }
        
        
        
    }
    
    
    
    func stopScrolling() {
        tableView.isScrollEnabled = false
        tableView.isScrollEnabled = true
    }
    
    func scrollToTop() {
        isTopPosition = true
        hideAllRadioButton()
        headerView?.hideUnderline()
        self.tableView.scrollToRow(at: customOverviewRow.indexPath!, at: .top, animated: true)
        
        // Remove subview if any
        for view in self.view.subviews {
            if let popupView = view as? PopupLibraryView {
                popupView.removeFromSuperview()
                break
            }
        }
    }
    
    func loadForm() {
        
        tableView.decelerationRate = UIScrollViewDecelerationRateNormal
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLogoHeader))
        goToTopView.addGestureRecognizer(tapGesture)
        
        self.form
        +++
            Section(Constants.sectionTag){ section in
                
                let customHeaderProvider = HeaderFooterProvider<CustomHeader>.nibFile(name: "CustomHeader", bundle: nil)
                var customHeaderView = HeaderFooterView<CustomHeader>(customHeaderProvider)
                customHeaderView.onSetupView = { (view,section)  in
                    self.headerView = view
                    view.delegate = self
                    view.logoHeaderButton.addTarget(self, action: #selector(self.didTapLogoHeader), for: .touchUpInside)
                }
                section.header = customHeaderView
                
                let customFooterProvider = HeaderFooterProvider<CustomFooterView>.nibFile(name: "CustomFooterView", bundle: nil)
                let customFooterView = HeaderFooterView<CustomFooterView>(customFooterProvider)
                section.footer = customFooterView
            
        }
        
            <<< CustomOverviewRow(Constants.overviewRow) {
                $0.cell.height = { self.heightRow}
            }
            
            <<< CustomColorPickerRow(Constants.colorPicker) {
                $0.cell.height = { self.heightRow }
            }.onCellSelection({ (cell, row) in
                self.startTimer()
            })
        
            <<< CustomBodyRow(Constants.designRow) {
                $0.cell.height = { self.heightRow}
                }.onCellSelection({ (cell, row) in
                    self.startTimer()
                })
            
            <<< CustomOperationRow(Constants.operationRow) {
                $0.cell.height = { self.heightRow }
                }.onCellSelection({ (cell, row) in
                    self.startTimer()
                })
            
            <<< CustomSafetyRow(Constants.safetyRow) {
                $0.cell.height = { self.heightRow }
                }.onCellSelection({ (cell, row) in
                   self.startTimer()
                })
            
            <<< CustomSpecificationRow(Constants.specificationRow) {
                
                
                $0.cell.height = { self.heightRow }
                
                
        }
            
            <<< CustomLibraryRow(Constants.libraryRow) {
                $0.cell.height = { self.heightRow }
                $0.cell.libraryView.delegate = self
        }.onCellSelection({ (cell, row) in
            self.startTimer()
        })
        
    }
    
    @IBAction fileprivate func didTapOnRadioButtonGroup(sender: UIButton) {
        let category = CustomHeader.LabelName(rawValue: sender.tag)!
        goToRowBy(category: category)
    }
    
    func didTapLogoHeader(sender: Any) {
        scrollToTop()
    }
    
    func goToRowBy(category: CustomHeader.LabelName, position: UITableViewScrollPosition = .top) {
        
        isTopPosition = false
        
        switch category {
        case .TongQuan:
            self.tableView.scrollToRow(at: self.customColorPickerRow.indexPath!, at: position, animated: true)
        case .ThietKe:
            self.tableView.scrollToRow(at: self.customBodyRow.indexPath!, at: position, animated: true)
        case .VanHanh:
            self.tableView.scrollToRow(at: self.customOperationRow.indexPath!, at: position, animated: true)
        case .AnToan:
            self.tableView.scrollToRow(at: self.customSafetyRow.indexPath!, at: position, animated: true)
        case .ThongSo:
            self.tableView.scrollToRow(at: self.customSpecificationRow.indexPath!, at: position, animated: true)
        case .ThuVien:
            self.tableView.scrollToRow(at: self.customLirabryRow.indexPath!, at: position, animated: true)
        }

        hideAllRadioButton(exclude: category)
        
        headerView?.switchState(category: category)
    }
    
    func hideAllRadioButton(exclude category: CustomHeader.LabelName? = nil) {
        for view in radioGroupStackview.subviews {
            if let button = view as? DLRadioButton {
                if category != nil {
                    let buttonCategory = CustomHeader.LabelName(rawValue: button.tag)!
                    if category == buttonCategory {
                        button.isSelected = true
                        break
                    }
                } else {
                    button.deselectOtherButtons()
                }
            }
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name.init(rawValue:Constant.Notification.tapInteractionNotification), object: nil, queue: nil) { (notification) in
            self.startTimer()
        }
    }
    
    func startTimer() {
        if !isTopPosition {
            self.stopTimer()
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                self.secondsPassed += 1
                print("Timer \(self.secondsPassed)")
                
                if self.secondsPassed == 60 {
                    
                    self.countdownView.isHidden = false
                    self.countdownView.animation = "fadeInLeft"
                    self.countdownView.animate()
                    
                }
                
                if self.secondsPassed > 60 {
                    
                    let second = self.timeCountdown - (self.secondsPassed % self.timeCountdown)
                    self.countdownLabel.text = "\(second)s"
                    
                }
                
                if self.secondsPassed == 70 {
                    self.scrollToTop()
                    self.stopTimer()
                }

            })
        }
    }
    
    func stopTimer() {
        self.timer.invalidate()
        secondsPassed = 0
        if !self.countdownView.isHidden {
            self.countdownView.animation = "fadeOut"
            self.countdownView.animateNext {
                self.countdownLabel.text = "10s"
                self.countdownView.isHidden = true
                
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController: CustomLibraryViewProtocol {
    func didTapImage(withView View: CustomLibraryView,withIndex index: Int ) {
        print("Tapped image \(index)")
        let popupView = PopupLibraryView.instanceFromNib()
        popupView.selectedIndex = index
        self.view.insertSubview(popupView, belowSubview: self.countdownView)

        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -10).isActive = true
        popupView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
        popupView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -10).isActive = true
        popupView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -CustomFooterView.height).isActive = true
        
        startTimer()

    }
}

extension ViewController: CustomHeaderProtocol {
    func didTapCategory(name: CustomHeader.LabelName) {
        goToRowBy(category: name)
        
    }
}


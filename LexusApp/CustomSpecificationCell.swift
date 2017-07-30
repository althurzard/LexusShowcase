//
//  CustomSpecificationCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka

class CustomSpecificationCell: Cell<Bool>, CellType {

    var dataSource: [String] = ["ĐỘNG CƠ","VẬN HÀNH","KHUNG GẦM","KÍCH THƯỚC","BÁNH VÀ LỐP XE","TIỆN NGHI","THIẾT BỊ TIÊU CHUẨN","HỆ THỐNG GIẢI TRÍ","AN TOÀN","CÁC TÍNH NĂNG KHÁC"]
    
    @IBOutlet weak var rightView: AccordionView!
    @IBOutlet weak var leftView: AccordionView!
    public override func setup() {
        super.setup()
        setupLeftView()
        setupRightView()
        
        
        
    }
    
    func setupLeftView() {
        // Left
    
        
        let item1 = Parent(state: .collapsed, childs: [
            Specification(title: "Loại động cơ", description: "I4 16 van trục cam kép, Turbo tăng áp"),
            Specification(title: "Dung tích xy lanh", description: "1.998 cc"),
            Specification(title: "Công suất tối đa", description: "241 Hp /5.800 Rpm"),
            Specification(title: "Momen xoắn cực đại", description: "350 Nm /1.650-4.400 Rpm"),
            Specification(title: "Hệ dẫn động", description: "Dẫn động cầu sau"),
            Specification(title: "Hộp số", description: "Hộp số tự động 8 cấp thể thao"),
            Specification(title: "Vận tốc tối đa", description: "230 km/h"),
            Specification(title: "Khả năng tăng tốc", description: "7,5 giây (0 - 100 km/h)"),
            Specification(title: "Mức tiêu hao nhiên liệu"),
            Specification(title: "Chu trình tổ hợp", description: "8,0L/100km"),
            Specification(title: "Chu trình đô thị cơ bản", description: "11,2L/100 km"),
            Specification(title: "Chu trình đô thị phụ", description: "6,1L/100km"),
            Specification(title: "Tiêu chuẩn khí thải", description: "Euro 4")
            ], title: "VẬN HÀNH VÀ HỆ DẪN ĐỘNG")
        
        let item2 = Parent(state: .collapsed, childs: [
            Specification(title: "Trước", description: "Đĩa thông gió 334mm"),
            Specification(title: "Sau", description: "Đĩa thông gió 330mm"),
            Specification(title: "Hệ thống treo"),
            Specification(title: "Trước", description: "Tay đòn kép"),
            Specification(title: "Sau", description: "Đĩa liên kết"),
            Specification(title: "Hệ thống lái", description: "Trợ lực điện"),
            Specification(title: "Vận tốc tối đa", description: "230 km/h"),
            ], title: "KHUNG GẦM")
        let item3 = Parent(state: .collapsed, childs: [
            Specification(title: "Tổng thể"),
            Specification(title: "Chiều dài", description: "4.695 mm"),
            Specification(title: "Chiều rộng", description: "1.840 mm"),
            Specification(title: "Chiều cao", description: "1.395 mm"),
            Specification(title: "Chiều dài cơ sở", description: "2.730 mm"),
            Specification(title: "Vệt bánh xe"),
            Specification(title: "Bán kính vòng quay tối thiểu (Lốp)", description: "5,2 m"),
            Specification(title: "Trọng lượng"),
            Specification(title: "Trọng lượng không tải", description: "1.675 - 1.725 kg"),
            Specification(title: "Trọng lượng toàn tải", description: "2.170 kg"),
            Specification(title: "Dung tích bình xăng", description: "66L"),
            ], title: "KÍCH THƯỚC")
        let item4 = Parent(state: .collapsed, childs: [
            Specification(title: "Vành hợp kim nhôm 235/45R18"),
            Specification(title: "Lốp tạm thời")
            ], title: "VÀNH VÀ LỐP")
        
        
        leftView.tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: leftView.parentCellIdentifier)
        leftView.tableView.register(UINib(nibName: "DetailSpecificationCell", bundle: nil), forCellReuseIdentifier: leftView.childCellIdentifier)
        
        
        leftView.sectionTitle = "THÔNG SỐ KỸ THUẬT"
        
        leftView.dataSource = [item1, item2, item3, item4]
        leftView.numberOfCellsExpanded = .one
        leftView.total = 4
        
    }
    
    func setupRightView() {
        let item1 = Parent(state: .collapsed, childs: [
            Specification(title: "Hệ thống chống bó cứng phanh đa địa hình (Multi-terrain ABS)"),
            Specification(title: "Hỗ trợ lực phanh (BA)"),
            Specification(title: "Hệ thống phân phối lực phanh điện tử (EBD)"),
            Specification(title: "Hệ thống ổn định thân xe (VSC)"),
            Specification(title: "Hệ thống kiểm soat lực bám đường (TRAC)"),
            Specification(title: "Hệ thống hỗ trợ khởi hành ngang dốc (HAS)"),
            Specification(title: "Hệ thống quản lý động lực học tích hợp (VDIM)"),
            Specification(title: "Hệ thống điều khiển hành trình"),
            Specification(title: "Hệ thống 8 túi khí"),
            Specification(title: "Túi khí phía trước cho ghế lái & ghế phụ (2)"),
            Specification(title: "Túi khí đầu gối hàng ghế trước (2)"),
            Specification(title: "Túi khí bên hàng ghế trước (2)"),
            Specification(title: "Dây đai an toàn với Chức năng căng đai khẩn cấp hàng ghế trước và sau; Bộ hạn chế tì lực vai hàng ghế trước ", cellHeight: 80.0),
            Specification(title: "Camera lùi"),
            Specification(title: "Cảm biến quanh xe (Trước: 4, Sau: 4)"),
            Specification(title: "Hệ thống cảnh báo điểm mù (BSM)"),
            Specification(title: "Hệ thống cảnh báo va chạm khi lùi (RCTA)"),
            Specification(title: "Tính năng mui xe an toàn")
            ], title: "AN TOÀN VÀ NHANH")
        let item2 = Parent(state: .collapsed, childs: [
            Specification(title: "Đèn pha 3 bóng LED"),
            Specification(title: "Đèn chiếu sáng ban ngày LED"),
            Specification(title: "Rửa đèn pha"),
            Specification(title: "Đèn sương mù phía trước LED"),
            Specification(title: "Đèn sương mù phía sau"),
            Specification(title: "Cụm đèn sau LED"),
            Specification(title: "Đèn phanh trên cao LED"),
            Specification(title: "Gương chiếu hậu ngoài có chức năng gập điện, mặt gương điều chỉnh tự động, sấy gương, nhớ vị trí, mặt gương chống chói, tích hợp đèn báo rẽ", cellHeight: 80.0),
            Specification(title: "Cửa kính điều chỉnh điện lên/xuống với chức năng chống kẹt (lên/xuống)", cellHeight: 80.0),
            Specification(title: "Kính chắn gió và kính cửa sổ phía trước cách âm"),
            Specification(title: "Cửa sổ trời điều chỉnh điện nghiêng/trượt, một chạm đóng/mở, chống kẹt", cellHeight: 80.0),
            Specification(title: "Cốp sau mở bằng điện"),
            Specification(title: "Nắp bình nhiên liệu mở bằng điện"),
            Specification(title: "Ống xả đôi")
            ], title: "NGOẠI THẤT")
        let item3 = Parent(state: .collapsed, childs: [
            Specification(title: "Gương chiếu hậu bên trong tự động điều chỉnh ngày và đêm, mặt gương chống chói", cellHeight: 80.0),
            Specification(title: "Trục lái điều chỉnh điện với chức năng nhớ vị trí"),
            Specification(title: "Lẫy chuyển số trên vô lăng"),
            Specification(title: "Màn hình hiển thị đa thông tin"),
            Specification(title: "Cần số bọc da"),
            Specification(title: "Ốp gỗ và da cho cánh cửa, bảng táp lô, vô lăng"),
            Specification(title: "Hệ thống mở cửa và khởi động thông minh"),
            Specification(title: "Chìa khóa dạng thẻ"),
            ], title: "NỘI THẤT")
        let item4 = Parent(state: .collapsed, childs: [
            Specification(title: "Chất liệu ghế da cao cấp"),
            Specification(title: "Ghế lái điều chỉnh điện 10 hướng, hỗ trợ tựa lưng ghế, với chức năng nhớ vị trí", cellHeight: 80.0),
            Specification(title: "Ghế hành khách phía trước điều chỉnh điện 8 hướng"),
            Specification(title: "Làm mát ghế (Ghế lái và ghế phụ)")
            ], title: "GHẾ")
        let item5 = Parent(state: .collapsed, childs: [
            Specification(title: "Hệ thống điều hòa tự động 2 vùng độc lập"),
            Specification(title: "Tự động điều chỉnh lấy gió")
            ], title: "HỆ THỐNG ĐIỀU HOÀ")
        let item6 = Parent(state: .collapsed, childs: [
            Specification(title: "Hệ thống âm thanh Mark Levinson 17 loa"),
            Specification(title: "Màn hình LCD 7 inch"),
            Specification(title: "DVD, USB, AUX, Bluetooth"),
            Specification(title: "2 ổ cắm điện 12V")
            ], title: "HỆ THỐNG GIẢI TRÍ")
        
        rightView.tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: leftView.parentCellIdentifier)
        rightView.tableView.register(UINib(nibName: "DetailSpecificationCell", bundle: nil), forCellReuseIdentifier: leftView.childCellIdentifier)
        
        rightView.sectionTitle = "CÔNG NGHỆ ỨNG DỤNG TRÊN XE"
        rightView.dataSource = [item1, item2, item3, item4, item5, item6]
        rightView.numberOfCellsExpanded = .one
        rightView.total = 6
        
    }
    
    func collapseAllCell() {
        self.rightView.collapseAllCell()
        self.leftView.collapseAllCell()
    }
    
    public override func update() {
        super.update()
        selectionStyle = .none
    }
    
}



final class CustomSpecificationRow: Row<CustomSpecificationCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomSpecificationCell>(nibName: "CustomSpecificationCell")
        
    }
    
}

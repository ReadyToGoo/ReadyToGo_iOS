//
//  ParticipatingMemberCollectionViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

class ParticipatingMemberViewCell: UICollectionViewCell {
    static let id = "ParticipatingMemberCell"
    
    weak var delegate: ParticipatingMemberCollectionViewDelegate?
    
    var buttonAction: (() -> Void)?
    
    var memberData = MemberModel("crown", nil, "what")
    
    private let memberProfileBtn: UserProfileImageView = {
        let view = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.frame.height/2
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let memberName: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 10, 10)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white.withAlphaComponent(0.35)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 13
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.memberProfileBtn)
        self.contentView.addSubview(self.memberName)
        
        setConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
        
        isUserInteractionEnabled = true
    }
    
    @objc private func cellTapped() {
        delegate?.didSelectMember(memberData)
    }
    
    func getMemberData(data: MemberModel) {
        self.memberData = data
        self.fetchData()
    }
    
    private func fetchData() {
        self.memberName.text = self.memberData.name
        self.memberProfileBtn.setImage(image: nil)
    }
    
    private func setConstraints() {
        memberProfileBtn.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110)
        }
        
        memberName.snp.makeConstraints { make in
            make.top.equalTo(memberProfileBtn.snp.bottom).offset(4)
            make.centerX.equalTo(memberProfileBtn.snp.centerX)
        }
    }
}

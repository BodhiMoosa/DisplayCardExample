//
//  ViewController.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/25/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class TabOneVC: UIViewController {
    
    var tableView       : UITableView!
    var cardTableView   : UITableView!
    var rowHeight       = 50     // use this to keep keep card limited in height based on cardRowHeight
    let cardView        = CardView()
    var origin          : CGRect!
    var topPoint        : CGFloat!
    var bottomPoint     : CGFloat!
    var data            = [Character]()
    var character       : Character?
    var selectionOfData = ["Gender: ", "House: ", "Actor: ", "Patronus: "]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableSetUp()
        cardTableViewSetUp()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        //topPoint    = view.safeAreaInsets.top //highest point we want our card to scroll up
        topPoint        = view.frame.height - (CGFloat(rowHeight * 5) + view.safeAreaInsets.bottom)
        bottomPoint = view.frame.height - (50 + view.safeAreaInsets.bottom) // lowest point we want our card to scroll down
    }

    private func configure() {
        view.backgroundColor    = .systemTeal
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(draggy))
        cardView.grabView.addGestureRecognizer(gesture)
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height + 100),
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    private func tableSetUp() {
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.sendSubviewToBack(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseID)
        tableView.rowHeight = 50
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func cardTableViewSetUp() {
        cardTableView = UITableView()
        cardTableView.backgroundColor = .systemTeal
        cardTableView.tableFooterView = UIView()
        cardTableView.delegate = self
        cardTableView.dataSource = self
        cardTableView.rowHeight = CGFloat(rowHeight)
        cardView.addSubview(cardTableView)
        cardTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardTableView.leadingAnchor.constraint(equalTo: cardView.bodyView.leadingAnchor),
            cardTableView.trailingAnchor.constraint(equalTo: cardView.bodyView.trailingAnchor),
            cardTableView.topAnchor.constraint(equalTo: cardView.bodyView.topAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: cardView.bodyView.bottomAnchor)
        ])
        cardTableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseID)
    }
    @objc private func draggy(sender: UIPanGestureRecognizer) {
        let card = cardView

        switch sender.state {
        case .began:
            origin = card.frame
        case .changed:
            let translation = sender.translation(in: card.superview)
            if (card.frame.origin.y >= topPoint && translation.y < 0) || (card.frame.origin.y <= bottomPoint && translation.y > 0)  {
                card.frame = origin.offsetBy(dx: 0, dy: translation.y)
            }
        case .ended:
            if card.frame.origin.y <= topPoint {
                let offset = topPoint - card.frame.origin.y
                UIView.animate(withDuration: 0.1) {
                    card.frame = card.frame.offsetBy(dx: 0, dy: offset)
                }
            } else if card.frame.origin.y >= bottomPoint {
                let offset = bottomPoint - card.frame.origin.y
                UIView.animate(withDuration: 0.1) {
                    card.frame = card.frame.offsetBy(dx: 0, dy: offset)
                }
            }
        default:
            return
        }
    }
    
    private func getData() {
        NetworkManager.shared.getCharacters() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                self.data = characters
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.cardTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TabOneVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return data.count
        } else {
            return selectionOfData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseID) as! CharacterCell
        if tableView == self.tableView {
            cell.set(title: data[indexPath.row].name, alignment: .center)
            if let character = character, character.name == data[indexPath.row].name {
                cell.label.textColor = .white
            } else {
                cell.label.textColor = .black
            }
        } else {
            cell.set(title: selectionOfData[indexPath.row], alignment: .left)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            character = data[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as! CharacterCell
            cell.label.textColor = .white
            selectionOfData = ["Gender: " + character!.gender.rawValue, "House: " + character!.house, "Actor: " + character!.actor, "Patronus: " + character!.patronus]
            cardTableView.reloadData()
            print(cell.frame)
            UIView.animate(withDuration: 0.1, animations: {
                self.cardView.frame = self.cardView.frame.offsetBy(dx: 0, dy: -10)
            }) { (true) in
                self.cardView.frame = self.cardView.frame.offsetBy(dx: 0, dy: 10)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CharacterCell {
            cell.label.textColor = .black
        }
    }

}

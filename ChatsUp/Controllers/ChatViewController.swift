//
//  ChatViewController.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 5.01.2024.
//

import UIKit
import MessageKit




struct Message: MessageType {
    var sender: SenderType  // MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Sender: SenderType {
    var photoUrl: String
    var senderId: String
    var displayName: String
}




class ChatViewController: MessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        view.backgroundColor = blueGreenColor
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
    }
}


extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentSender: MessageKit.SenderType {
        <#code#>
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        <#code#>
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        <#code#>
    }
    
    
}


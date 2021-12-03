//
//  SnackbarViewModel.swift
//  ToastAndSnackBar
//
//  Created by alican on 1.12.2021.
//

import Foundation
import UIKit

typealias Handler = (()-> Void)

enum SnackbarViewType{
    case info
    case action(handler : Handler)
}

struct SnackbarViewModel{
    let type : SnackbarViewType
    let text : String
    let image : UIImage?
    
    
}

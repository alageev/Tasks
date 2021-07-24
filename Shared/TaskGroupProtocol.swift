//
//  TaskGroupProtocol.swift
//  Tasks
//
//  Created by Алексей Агеев on 22.07.2021.
//

import SwiftUI

protocol TaskGroupViewProtocol: View {
    var header: LocalizedStringKey { get }
    var tasks: [Task] { get }
    
    init(header: LocalizedStringKey, tasks: [Task])
}

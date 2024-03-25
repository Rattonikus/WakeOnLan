//
//  testView.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 3/25/24.
//

import SwiftUI

struct testView: View
{
    var testerDo : WakeOnClient
    var body: some View
    {
        Text(testerDo.testComp(computer: demoComputer))
    }
}

#Preview {
    testView(testerDo: WakeOnClient())
}

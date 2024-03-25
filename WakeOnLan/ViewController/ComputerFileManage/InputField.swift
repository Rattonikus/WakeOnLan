//
//  InputField.swift
//  WakeOnLan
//
//  Created by Cameron Elkins on 2/20/24.
//

import SwiftUI

struct InputField: View
{

    let hint : String
    
    @Binding var result : String
    
    var body: some View
    {
        TextField(hint, text: $result)
            .autocorrectionDisabled()
    }
}

#Preview ("Input Field Demo")
{
    InputField(hint: "the hint", result: .constant("The bound value"))
}

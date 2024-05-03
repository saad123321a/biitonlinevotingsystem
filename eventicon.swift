import SwiftUI

struct CreateEventIcon: View {
    var body: some View {
        ZStack {
            // Calendar icon
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue) // You can change the color as needed
                .frame(width: 50, height: 60)
            
            // Calendar lines
            Rectangle()
                .fill(Color.white)
                .frame(width: 35, height: 2)
                .offset(y: -10)
            Rectangle()
                .fill(Color.white)
                .frame(width: 35, height: 2)
                .offset(y: 10)
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: 20)
                .offset(x: -12)
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: 20)
                .offset(x: 12)
            
            // Plus sign
            Rectangle()
                .fill(Color.white)
                .frame(width: 25, height: 2)
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: 25)
        }
    }
}

struct Content: View {
    var body: some View {
        CreateEventIcon()
        
            .padding()
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        Content()
    }
}

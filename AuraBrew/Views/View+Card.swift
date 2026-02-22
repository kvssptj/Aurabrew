import SwiftUI

extension View {
    /// Notion-style card: white background + thin separator border.
    func notionCard(cornerRadius: CGFloat = 12) -> some View {
        self
            .background(Color(.systemBackground),
                        in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.separator).opacity(0.6), lineWidth: 0.5)
            )
    }
}

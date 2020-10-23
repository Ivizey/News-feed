import UIKit

let formatter = ISO8601DateFormatter()
let dateFormatter = DateFormatter()
let date: Date? = formatter.date(from: "2020-10-10T12:21:00Z")
dateFormatter.dateFormat = "MMM d, h:mm a"
print(dateFormatter.string(from: date!))
print(type(of: dateFormatter.string(for: date!)))

import Foundation

let learnerName = "Plato"
var studyMinutes = 25
studyMinutes += 10

let focusTopic = "SwiftUI state"
let progressMessage = "\(learnerName) studied \(focusTopic) for \(studyMinutes) minutes."

print("=== Constants and Variables ===")
print(progressMessage)

let targetMinutes = 45
let remainingMinutes = max(targetMinutes - studyMinutes, 0)

print("Target minutes:", targetMinutes)
print("Remaining minutes:", remainingMinutes)
print("\nPractice Prompt: convert these values into a reusable summary function.")

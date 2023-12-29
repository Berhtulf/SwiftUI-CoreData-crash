When using swipeActions modifier on a List row view, as soon as we try to use a button with destructive role as a custom delete action, the app crashes. Crash only occurs if we try to delete the last element in the list and only if the row view holds a reference to the Core Data managed object via @ObservedObject property wrapper.

Possible workaround right now are to not use swipeActions and instead use onDelete from ForEach, which loses customization, such as additional confirmation dialogs etc. Or removing the role from a button as seen with the Delete button thats tinted with green color.

Another SO thread about this issue - https://stackoverflow.com/questions/75352046/swiftui-app-crashes-when-using-destructive-button-in-swipeactions-and-obser

- A step-by-step set of instructions to reproduce the problem (if possible)
  
1. Clone the repository and try running the project in either preview, simulator or on device.
2. Go to the list view and use swipeAction to delete the LAST item in the list.
     - the crashing button is the one with an X symbol as icon. All other swipe buttons are there to showcase other solutions, which do not crash the app.

- What results you expected
  
Last list item is deleted from the list and core data context. Application does not crash

- What results you actually saw
  
App crashes after deleting the last item in a list

Error: Thread 1: "attempt to delete item 2 from section 0 which only contains 2 items before the update“

- The version of Xcode you are using
  
Version 15.1 (15C65)

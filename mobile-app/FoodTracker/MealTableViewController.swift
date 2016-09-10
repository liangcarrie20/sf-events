import UIKit

class MealTableViewController: UITableViewController {
    // MARK: Properties
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            events += savedMeals
        } else {
            // Load the sample data.
            loadSampleEvents()
        }
    }
    
    func loadSampleEvents() {
        let photo1 = UIImage(named: "sumo")!
        let event1 = Event(name: "Sumo Wrestling Festival", photo: photo1, rating: 4, desc: "This is really fun!")!
        
        let photo2 = UIImage(named: "sundae")!
        let event2 = Event(name: "Chocolate Festival", photo: photo2, rating: 5, desc: "This is really fun!")!
        
        let photo3 = UIImage(named: "opera")!
        let event3 = Event(name: "Opera in the Park", photo: photo3, rating: 3, desc: "This is really fun!")!
        
        let photo4 = UIImage(named: "nfl")!
        let event4 = Event(name: "NFL Red Zone Watch & Brunch", photo: photo4, rating: 1, desc: "This is really fun!")!
        
        let photo5 = UIImage(named: "giants")!
        let event5 = Event(name: "Giant Race Volunteer", photo: photo5, rating: 1, desc: "This is really fun!")!
        
        let photo6 = UIImage(named: "sing")!
        let event6 = Event(name: "The Sunday Sing Thing", photo: photo6, rating: 1, desc: "This is really fun!")!
        
        let photo7 = UIImage(named: "witch")!
        let event7 = Event(name: "Witches' Brew Comedy", photo: photo7, rating: 1, desc: "This is really fun!")!
        
        let photo8 = UIImage(named: "women")!
        let event8 = Event(name: "Women in Science", photo: photo8, rating: 1, desc: "This is really fun!")!
        
        let photo9 = UIImage(named: "poetry")!
        let event9 = Event(name: "Poetry Readings @ Lunch", photo: photo9, rating: 1, desc: "This is really fun!")!
        
        let photo10 = UIImage(named: "whiskey")!
        let event10 = Event(name: "The Macallan", photo: photo10, rating: 1, desc: "This is really fun!")!
        
        events += [event1, event2, event3, event4, event5, event6, event7, event8, event9, event10]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = events[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = events[indexPath.row]
                mealDetailViewController.event = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
    

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                events[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
                events.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            saveMeals()
        }
    }
    
    // MARK: NSCoding
    
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    func loadMeals() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }
}

//
//  MediasViewController.swift
//  Metatron
//
//  Copyright (c) 2016 Almaz Ibragimov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

import Metatron

class MediasViewController: UITableViewController {

    // MARK: Instance Properties

    var medias: [MPEGMedia] = SampleMedias.regular.medias

    // MARK: Instance Methods

    @IBAction func applyMediaDetails(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }

    @IBAction func closeMediaDetails(segue: UIStoryboardSegue) {
    }

    // MARK:

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medias.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell

        let media = self.medias[indexPath.row]

        if let image = UIImage(data: Data(media.coverArt.data)) {
            cell.coverArtView.image = image
        } else {
            cell.coverArtView.image = UIImage(named: "CoverArtField")
        }

        cell.titleLabel.text = media.title
        cell.artistLabel.text = media.artists.joined(separator: " & ")
        cell.albumLabel.text = media.album

        let seconds = Int(media.duration / 1000.0 + 0.5)

        cell.durationLabel.text = String(format: "%d:%02d", seconds / 60, seconds % 60)
        cell.bitRateLabel.text = String(media.bitRate)
        cell.sampleRateLabel.text = String(media.sampleRate)

        return cell
    }

    // MARK:

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowMediaDetails" else {
            return
        }

        guard let navigationController = segue.destination as? UINavigationController else {
            return
        }

        let topViewController = navigationController.topViewController

        guard let detailsViewController = topViewController as? MediaDetailsViewController else {
            return
        }

        if let indexPath = self.tableView.indexPathForSelectedRow {
            detailsViewController.media = self.medias[indexPath.row]
        } else {
            detailsViewController.media = nil
        }
    }
}

# Audio Fingerprinting

This is an implementation of basic audio fingerprinting algorithm to track copyright violations automatically

## Getting Started

You can put the audio files under the /songs_in_the_database folder thenn run the reformat_songs_in_the_dabase.m script, to format them to further process. It saves formatted versions under the /songs_in_the_database_formatted folder. Save the files to match under /songs_to_match folder. Before doing matching make sure that update_database.m script is run, and all the files under /songs_in_the_database_formatted saved as dictionaries corresponding to fingerprinted version. Then you can match the song by running the match_song.m script. Before doing so just change dictionary location in the code corresponding to desired song.



## Authors

* **Mustafa Akur** - *Initial work* - [akurmustafa](https://github.com/akurmustafa)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Project inspired by the work [how shazma works](http://coding-geek.com/how-shazam-works/)

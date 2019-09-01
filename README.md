# mp3Tag
Addon Bash Script which utilizes mid3v2 to Tag Audio Files with their own File Name.

Do keep in mind if ran without the -s flag, it will start tagging every .mp3 file in the folder the bash file is located!

./mp3Tag -h

	Help Page:
	
	mp3 Tag is an addon bash script that utilizes mid3v2. You can
	install mid3v2 by sudo apt-get install python-mutagen.

	Avaialble Commands:
	-h: Help!
	-b: Cut Backwards
	-c: Cutoff Text [Requires Arguments] #NOTE: Default Cuts Forward!
	Ex: ./mp3Tag -c "- " -s "/M - BGM" Results in "BGM"
	-s: Single File [Requires Arguments]

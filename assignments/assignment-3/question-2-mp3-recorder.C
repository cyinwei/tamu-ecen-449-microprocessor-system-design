/* Pseudocode for a MP3 record and playback using the specs required for question 2.
 *   For ECEN 449 Assignment 3.
 * @Yinwei Zhang
 */

//assuming we're writing OS code

mp3* recordMP3(int numBytes) { //assuming mp3 is the data struct we use to store sound
	mp3* sound = malloc(numBytes); 
	int count = 0;
	while (numBytes != count) {
		if (R3 == 1) { //want to wait until the next time there's new data
			mp3[count] = R4;
			R3 = 0;
			count++;
    }
	}

	return sound;	
}

mp3* playMP3(mp3* sound, int numBytes) { //numBytes is size
	int count = 0;
	while (numBytes != count) {
		if (R1 == 0) { 
			mp3[count] = R2;
			R1 = 1;
			count++
    }
	}

	return sound;	
}

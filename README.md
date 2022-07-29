# ThreeChannelEqualizer
This repo contains one .m file with MATLAB code that when run, acts as a three channel equalizer and miniature DJ System.<br><br><br>

## Introduction
Since the inception of audio production, a variety of tones have been fabricated from recordings of music or articulated words. Some of which are not the most gratifying to listen to, leaving auditors with the urge to modify, or fine-tune, the output of the sound.

The aspiration and yearning to adjust vexatious tones sparked audio engineers to develop what is known as a graphic equalizer (EQ). In short, an EQ empowers users to revamp sound by augmenting or cutting certain frequencies. One of the most manageable forms of EQ is the 3-channel graphic equalizer consisting of a bandpass, lowpass, and highpass filter. This particular graphic equalizer can modify sound quality by enhancing the bass with the lowpass filter, minimizing treble with the highpass filter, or it can merely ameliorate overall sound quality. <br>

## Summary
Using MATLAB software, a 3-channel graphic equalizer (EQ) will be created to effectively adjust audio inputted within the software code. 

To compute the software-based EQ, audio samples will be fed to the analog-to-digital converter that will convert it into a discrete signal. From this signal, it will be split into 3 bands: bandpass filter (known as a mid-pass filter), lowpass filter (known as a bass filter), and a highpass filter (known as a treble filter). Then, each individual channel will be scaled by a gain factor (g1, g2, and g3). Once scaled, all 3 bands will be combined to form a single signal that will proceed through a digital-to-analog converter. This will produce an analog signal from a digital signal where it will then finally continue through an audio amplifier and be played back. <br><br><br><br>

## References
Here is a huge pile of references that may be of help in order to understand what the purpose of this repo is. Iterating through the references will also piece together the logical code in the .m file.

<br>

[1] https://www.adobe.com/creativecloud/video/discover/graphic-equalizer.html<br>

[2] https://www.cras.edu/what-is-an-audio-production/

[3] https://www.thepodcasthost.com/equipment/tools-trade-equalizers-eq/

[4] https://www.electronics-tutorials.ws/combination/analogue-to-digital-converter.html

[5] https://staff.fnwi.uva.nl/r.vandenboomgaard/SP20162017/ComplexDomain/ZDomain/z_transfer.html

[6] https://www.sciencedirect.com/topics/computer-science/bilinear-transformation

[7] https://www.tutorialspoint.com/digital_signal_processing/dsp_z_transform_inverse.htm

[8] https://www.mathworks.com/help/matlab/ref/fft.html

[9] https://www.nti-audio.com/en/support/know-how/fast-fourier-transform-fft

[10] https://www.sciencedirect.com/topics/engineering/low-pass-filters

[11] https://hometheateracademy.com/lower-hz-means-more-bass/#:~:text=Generally%2C%20lower%20Hz%20means%20more,deepest%20bass%20in%20most%20tracks.

[12] https://www.sciencedirect.com/topics/engineering/bandpass-filters

[13] https://eng.libretexts.org/Bookshelves/Electrical_Engineering/Signal_Processing_and_Modeling/Book%3A_Signals_and_Systems_(Baraniuk_et_al.)/12%3A_ZTransform_and_Discrete_Time_System_Design/12.04%3A_Inverse_Z-Transform

[14] https://www.dummies.com/article/business-careers-money/careers/trades-tech-engineering-careers/signals-and-systems-working-with-transform-theorems-and-pairs-166452

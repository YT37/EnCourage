from word import Sentence
import speech_recognition as sr

r = sr.Recognizer()

try:
	with sr.Microphone() as source:
		r.adjust_for_ambient_noise(source, duration = 5)

		print("Listening...")
		audio = r.listen(source)

		print("Recognizing...")

		text = r.recognize_sphinx(audio)

		print("Did you say " + text)

except sr.RequestError as e: 
	print(f"Could not request results; {e}")

except sr.UnknownValueError: 
	print("unknown error occured")

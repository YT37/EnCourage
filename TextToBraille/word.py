alpha = {"a":[1, 0, 0, 0, 0, 0], "b":[1, 1, 0, 0, 0, 0], "c":[1, 0, 0, 1, 0, 0], "d":[1, 0, 0, 1, 1, 0], "e":[1, 0, 0, 0, 1, 0],
		 "f":[1, 1, 0, 1, 0, 0], "g":[1, 1, 0, 1, 1, 0], "h":[1, 1, 0, 0, 1, 0], "i":[0, 1, 0, 1, 0, 0], "j":[0, 1, 0, 1, 1, 0],
		 "k":[1, 0, 1, 0, 0, 0], "l":[1, 1, 1, 0, 0, 0], "m":[1, 0, 1, 1, 0, 0], "n":[1, 0, 1, 1, 1, 0], "o":[1, 0, 1, 0, 1, 0],
		 "p":[1, 1, 1, 1, 0, 0], "q":[1, 1, 1, 1, 1, 0], "r":[1, 1, 1, 0, 1, 0], "s":[0, 1, 1, 1, 0, 0], "t":[0, 1, 1, 1, 1, 0],
		 "u":[1, 0, 1, 0, 0, 1], "v":[1, 1, 1, 0, 0, 1], "w":[0, 1, 0, 1, 1, 1], "x":[1, 0, 1, 1, 0, 1], "y":[1, 0, 1, 1, 1, 1],
		 "z":[1, 0, 1, 0, 1, 1]}

words = {"but":alpha["b"], "can":alpha["c"], "do":alpha["d"], "every":alpha["e"], "from":alpha["f"], "go":alpha["g"], "have":alpha["h"],
		 "just":alpha["j"], "knowledge":alpha["k"], "like":alpha["l"], "more":alpha["m"], "not":alpha["n"], "people":alpha["p"],
		 "quite":alpha["q"], "rather":alpha["r"], "so":alpha["s"], "that":alpha["t"], "us":alpha["u"], "very":alpha["v"],
		 "will":alpha["w"], "it":alpha["x"], "you":alpha["y"], "as":alpha["z"], "and":[1, 1, 1, 1, 0, 1], "of":[1, 1, 1, 0, 1, 1],
		 "the":[0, 1, 1, 1, 0, 1], "with":[0, 1, 1, 1, 1, 1], "child":[1, 0, 0, 0, 0, 0], "shall":[1, 0, 0, 1, 0, 1],
		 "this":[1, 0, 0, 1, 1, 1], "which":[1, 0, 0, 0, 1, 1], "out":[1, 1, 0, 0, 1, 1], "for":[1, 1, 1, 1, 1, 1],
		 "was":[0, 0, 1, 0, 1, 1], "enough":[0, 1, 0, 0, 0, 1], "still":[0, 0, 1, 1, 0, 0], "his":[0, 1, 1, 0, 0, 1],
		 "were":[0, 1, 1, 0, 1, 1], "by":[0, 0, 1, 0, 1, 1], "to":[0, 1, 1, 0, 1, 0], "be":[0, 1, 1, 0, 0, 0]}

sounds = {"with":[0, 1, 1, 1, 1, 1], "con":words['can'], "dis":[0, 1, 0, 0, 1, 1], "ing":[0, 0, 1, 1, 0, 1], "the":[0, 1, 1, 1, 0, 1],
		  'ble':[0, 0, 1, 1, 1, 1], "for":[1, 1, 1, 1, 1, 1], "and":[1, 1, 1, 1, 0, 1], "com":[0, 0, 1, 0, 0, 1], "ch":words['child'],
		  "gh":[1, 1, 0, 0, 0, 1], "of":[1, 1, 1, 0, 1, 1], "ff":[0, 1, 1, 0, 1, 0], "gg":[0, 1, 1, 0, 1, 1], "sh":words['shall'],
		  "th":words['this'], "wh":words['which'], "ed":[1, 1, 0, 1, 0, 1], "er":[1, 1, 0, 1, 1, 1], "ou":words['out'],
		  "ow":[0, 1, 0, 1, 0, 1], "bb":[0, 1, 1, 0, 0, 0], "cc":words['can'], "dd":[0, 1, 0, 0, 1, 1], "en":[0, 1, 0, 0, 0, 1],
		  'gg':words['were'], "in":[0, 0, 1, 0, 1, 0], "st":[0, 0, 1, 1, 0, 0], "ar":[0, 0, 1, 1, 1, 0], "be":[0, 1, 1, 0, 0, 0],
		  "ea":[0, 1, 0, 0, 0, 0], "to":[0, 1, 1, 0, 1, 0], "by":[0, 0, 1, 0, 1, 1]}

nums = {"1":alpha["a"], "2":alpha["b"], "3":alpha["c"], "4":alpha["d"], "5":alpha["e"], "6":alpha["f"], "7":alpha["g"], "8":alpha["h"],
		"9":alpha["i"], "0":alpha["j"]}

punct = {".":[0, 1, 0, 0, 1, 1], ",":[0, 1, 0, 0, 0, 0], ";":[0, 1, 1, 0, 0, 0], ":":[0, 1, 0, 0, 1, 0], "'":[0, 0, 1, 0, 0, 0],
		 "?":[0, 1, 1, 0, 0, 1], "!":[0, 1, 1, 0, 1, 0], "(":[0, 1, 1, 0, 1, 1], ")":[0, 1, 1, 0, 1, 1], "“":[0, 1, 1, 0, 0, 1],
		 "”":[0, 0, 1, 0, 1, 1]}

class Cell():
	def __init__(self, letter, dots):
		self.letter = letter
		self.dots = dots

	def __str__(self):
		rep = []
		arr = []

		for i in range(len(self.dots)):
			arr.append("⚪ " if self.dots[i] else "⚫ ")

			if (i + 1) % 3 == 0:
				rep.append(arr)
				arr = []

		out = ""

		for i in range(len(rep[0])):
			for arr in rep:
				out += arr[i]

			out += "\n"

		return out

	def __list__(self):
		return self.dots

class Word():
	def __init__(self, word):
		self.word = word
		self.cells = []

		self.convert()

	def convert(self):
		if self.word.lower() in list(words):
			if self.word[0].isupper():
				self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

			self.cells.append(Cell(self.word.lower(), words[self.word.lower()]))
			return
			
		char_list = self._sound_check()

		char_follows = True
		num_follows = False
		caps = False

		for i in range(len(char_list)):
			char = char_list[i]

			if char.lower() in list(alpha):
				if not char_follows:
					if char.isupper():
						self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

						if len(self.word) - 1 > i:
							if self.word[i+1].isupper():
								self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
								caps = True

					else:
						self.cells.append(Cell("Letter Follows", [0, 0, 0, 0, 1, 1]))
						caps = False

					char_follows = True
					num_follows = False

				else:
					if char.isupper() and not caps:
						self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))

						if len(self.word) - 1 > i:
							if self.word[i+1].isupper():
								self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
								caps = True

							else:
								caps = False

				self.cells.append(Cell(char.lower(), alpha[char.lower()]))

			elif char in list(nums):
				if not num_follows:
					self.cells.append(Cell("Number Follows", [0, 0, 1, 1, 1, 1]))
					num_follows = True
					char_follows = False
					caps = False

				self.cells.append(Cell(char, nums[char]))

			elif char in list(punct):
				self.cells.append(Cell(char, punct[char]))
				caps = False

			elif char.lower() in list(sounds):
				if not char_follows:
					if char.isupper():
						if not caps:
							self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
							self.cells.append(Cell("Capital", [0, 0, 0, 0, 0, 1]))
							caps = True

					else:
						self.cells.append(Cell("Letter Follows", [0, 0, 0, 0, 1, 1]))
						caps = False

					char_follows = True
					num_follows = False

				else:
					if char.isupper():
						if not caps:
							self.cells.append([0, 0, 0, 0, 0, 1])
							self.cells.append([0, 0, 0, 0, 0, 1])
							caps = True

					else:
						caps = False

				self.cells.append(Cell(char.lower(), sounds[char.lower()]))

			else:
				print(f"{letter} doesn't have any match!")

	def _sound_check(self):
		char_list = list(self.word)
    
		for sound in list(sounds):
			for i in range(len(char_list)-len(sound)+1):
				joined = ''.join(char_list[i:i+len(sound)])

				if joined.lower() == sound:
					if (i == 0 and sound in ['ble', "ing"]) or (i != 0 and sound in ['be', "con", "dis", "com"]) or ((i == 0 and i == len(char_list)-1) and sound in ['bb', 'cc', 'dd', 'ff', 'gg', 'ea']):
						print("Continuing...", sound, i)
						continue

					if joined.islower():
						char_list[i] = sound

					elif joined.isupper():
						char_list[i] = sound.upper()

					else:
						continue
						
					del char_list[i+1:i+len(sound)]

		return char_list

	def __str__(self):
		rep = ""

		for cell in self.cells:
			rep += str(cell)
			rep += cell.letter
			rep += "\n\n"

		return rep

	def toSignal(self):
		return [[cell.dots for cell in self.cells], [cell.letter for cell in self.cells]]

	def toList(self):
		return self.cells

class Sentence():
	def __init__(self, sentence):
		self.sentence = sentence
		self.words = [Word(word) for word in sentence.split()]

	def display(self):
		out = []
		count = 0

		for i in range(len(self.words)):
			if count > 0:
				count -= 1
				continue

			word = self.words[i]

			out += str(word)

			if word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
				count = 1

				if len(self.words) > i + count:
					next_word = self.words[i+count]

				else:
					next_word = Word("None")

				while next_word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
					count += 1
					out += str(next_word)
					
					if len(self.words) > i + count:
						next_word = self.words[i+count]

					else:
						 break

				count -= 1

				if i + count != len(self.words) - 1:
					out += str(Cell("Space", [0, 0, 0, 0, 0, 0]))
					out += "Space\n\n"

			elif self.words.index(word) != len(self.words) - 1 and word.word.lower() not in ["to", "into", "by"]:
				out += str(Cell("Space", [0, 0, 0, 0, 0, 0]))
				out += "Space\n\n"

		return out

	def toSignal(self):
		out = []
		count = 0

		for i in range(len(self.words)):
			if count > 0:
				count -= 1
				continue

			word = self.words[i]
			w = word.toSignal()

			if word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
				count = 1
				
				if len(self.words) > i + count:
					next_word = self.words[i+count]

				else:
					next_word = Word("None")

				while next_word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
					count += 1
					
					signal = next_word.toSignal()
					w[0].extend(signal[0])
					w[1].extend(signal[1])
					
					if len(self.words) > i + count:
						next_word = self.words[i+count]

					else:
						break

				count -= 1

				if i + count != len(self.words) - 1:
					w[0].append([0, 0, 0, 0, 0, 0])
					w[1].append("Space")

			elif self.words.index(word) != len(self.words) - 1 and word.word.lower() not in ["to", "into", "by"]:
				w[0].append([0, 0, 0, 0, 0, 0])
				w[1].append("Space")

			out.append(w)

		for word in out:
			signals, letters = word

			for i in range(len(signals)):
				yield (signals[i], letters[i])

	def toList(self):
		out = []
		count = 0

		for i in range(len(self.words)):
			if count > 0:
				count -= 1
				continue

			word = self.words[i]
			w = word.toList()

			if word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
				count = 1

				if len(self.words) > i + count:
					next_word = self.words[i+count]

				else:
					next_word = Word("None")

				while next_word.word.lower() in ["a", "and", "for", "of", "the", "with"]:
					count += 1
					w.extend(next_word.toList())
					
					if len(self.words) > i+count:
						next_word = self.words[i+count]

					else:
						break

				count -= 1

				if i + count != len(self.words) - 1:
					w.append(Cell("Space", [0, 0, 0, 0, 0, 0]))

			elif self.words.index(word) != len(self.words) - 1 and word.word.lower() not in ["to", "into", "by"]:
				w.append(Cell("Space", [0, 0, 0, 0, 0, 0]))

			out.append(w)

		for word in out:
			for cell in word:
				yield cell

if __name__ == "__main__":
	sentence = Sentence(input("You: "))

	for signal, letter in sentence.toSignal():
		if len(input()) >= 0:
			print(letter)
			print(signal)

	# for cell in sentence.toList():
	# 	if len(input()) >= 0:
	# 		print(cell.letter)
	# 		print(cell)
